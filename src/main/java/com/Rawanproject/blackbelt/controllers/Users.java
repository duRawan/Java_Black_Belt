package com.Rawanproject.blackbelt.controllers;

import java.security.Principal;
import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.Rawanproject.blackbelt.models.Course;
import com.Rawanproject.blackbelt.models.Role;
import com.Rawanproject.blackbelt.models.User;
import com.Rawanproject.blackbelt.repositories.CourseRepository;
import com.Rawanproject.blackbelt.repositories.RoleRepository;
import com.Rawanproject.blackbelt.services.CourseService;
import com.Rawanproject.blackbelt.services.RoleService;
import com.Rawanproject.blackbelt.services.UserService;
import com.Rawanproject.blackbelt.validator.UserValidator;





@Controller
@RequestMapping("/")
public class Users {
	private UserValidator userValidator;
	private UserService userService;
	private RoleRepository rRepo;
	private CourseRepository courseRepository;
	private CourseService courseService;
	
	private void makeRoles() {
    	if(rRepo.findAll().size() == 0) {
    		Role user = new Role();
    		user.setType("ROLE_USER");
    		rRepo.save(user);
    		Role admin = new Role();
    		admin.setType("ROLE_ADMIN");
    		rRepo.save(admin);
    	}
    }
	public Users(UserValidator userValidator, UserService userService, RoleService roleService,
			CourseService courseService,RoleRepository rRepo,CourseRepository courseRepository) {
		this.userValidator = userValidator;
		this.userService = userService;
		this.courseService = courseService;
		this.courseRepository=courseRepository;
		this.rRepo=rRepo;
		makeRoles();
	}
	
	
	@RequestMapping(value={"/login","/register"})
	public String login(Model model,@RequestParam(value="error",required=false) String error,@RequestParam(value="logout",required=false) String logout){
		if(error != null){model.addAttribute("errorMessage","Invalid Credentials.");}
		if(logout != null){model.addAttribute("logoutMessage","Logout Successful");}
		
		model.addAttribute("user",new User());
		return "loginRegister.jsp";
	}
	
	@PostMapping("/registration")
    public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model) {
        userValidator.validate(user, result);

        if (result.hasErrors()) {
            return "loginRegister.jsp";
        }
        else if(userService.getAll().size() == 0) {
        		userService.saveUserWithAdminRole(user);
        		return "redirect:/login";
        } else {
        		userService.saveWithUserRole(user);
        		return "redirect:/login";
        }
    }

	@RequestMapping("/courses")
	public String allCourses(Principal principal, Model model, @ModelAttribute("Course") Course course) {
		String email = principal.getName();
        model.addAttribute("currentUser", userService.findByEmail(email));
        model.addAttribute("all", userService.getAll());
        model.addAttribute("allcourse", courseService.getAll());
        return "coursesPage.jsp";
	}

	@PostMapping("/createcourse")
	public String createCourse(Principal principal, @Valid @ModelAttribute("Course") Course course, BindingResult result,Model model) {
		if(course.getCapacity()>0&&!(course.getName().equals(""))&&!(course.getInstructor().equals(""))) {
		courseService.createCourse(course);
        return "redirect:/courses";
        }
		else {
			model.addAttribute("errormsg","Invalid inputs!");
			return "courseNew.jsp";
		}
	}
	
	@RequestMapping("/")
	public String gotoLogin() {
		return "redirect:/login";
	}
	
	@RequestMapping("/courses/{id}")
	public String courseInfo(Principal principal,@PathVariable("id") Long id,Model model) {
		Course course=courseService.getOneById(id);
		String email=principal.getName();
		model.addAttribute("currentUser",userService.findByEmail(email));
		model.addAttribute("allusers", course.getUsers());
		model.addAttribute("course",course);
		return "courseInfo.jsp";
	}
	
	@RequestMapping("/courses/{id}/edit")
	public String courseEdit(@PathVariable("id") Long id,Model model) {
		Course course=courseService.getOneById(id);
		model.addAttribute("course",course);
		return "courseEdit.jsp";
	}
	
	@PostMapping(value="/courses/{id}/edit")
    public String update(@Valid @ModelAttribute("Course") Course course, BindingResult result,Model model) {
		
		if (result.hasErrors()) {
            return "courseEdit.jsp";
        } else if(course.getCapacity()>0&&!(course.getName().equals(""))&&!(course.getInstructor().equals(""))){
        	courseService.updateCourse(course);
            return "redirect:/courses";
        }
        else {
        	model.addAttribute("errormsg","Invalid inputs!");
        	Course cours=courseService.getOneById(course.getId());
    		model.addAttribute("course",cours);
        	return "courseEdit.jsp";
        }
    }
	

	
	@RequestMapping("/signup/{id}")
	public String signup(Principal principal,@PathVariable("id") Long id) {
		String email=principal.getName();
		User user = userService.findByEmail(email);
		Course course = courseService.getOneById(id);
		List<Course> courses = user.getCourse();
		courses.add(course);
		user.setCourse(courses);
		course.setSignups(1);
		//courseService.updateCourse(course);
		userService.updateUser(user);
		return "redirect:/courses";
	}

	@RequestMapping("/courses/new")
	public String newCourse( @ModelAttribute("Course") Course course) {
		return "courseNew.jsp";
	}
	@RequestMapping("/courses/{id}/delete")
	public String deleteSub(@PathVariable("id") Long id) {
		courseService.deleteCourse(id);
		return "redirect:/courses";
	}
	@RequestMapping("/UnSignUp/{id}")
	public String unSignUp(Principal principal, @PathVariable("id") Long id) {
		String email=principal.getName();
		User user = userService.findByEmail(email);
		Course course = courseService.getOneById(id);
		List<User> users=course.getUsers();
		users.remove(user);
		course.setUsers(users);
		course.setSignups(-1);
		courseRepository.save(course);
		return "redirect:/courses/"+course.getId();
		
	}
	
	
}
