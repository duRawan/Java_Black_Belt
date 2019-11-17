package com.Rawanproject.blackbelt.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.Rawanproject.blackbelt.models.Course;
import com.Rawanproject.blackbelt.repositories.CourseRepository;


@Service
public class CourseService {

	private CourseRepository courseRepository;

	public CourseService(CourseRepository courseRepository) {
		super();
		this.courseRepository = courseRepository;
	}
	public List<Course> getAll(){
		return (List<Course>) courseRepository.findAll();
	}
	
	public Course getOneById(Long id) {
		Optional<Course> course= courseRepository.findById(id);
		if(course.isPresent()) {
			return course.get();
		}
		else {
			return null;
		}
	}
	
	public void createCourse(Course course) {
		courseRepository.save(course);
	}
	
	public void updateCourse(Course course) {
		Course c=getOneById(course.getId());
		course.setSignups(c.getSignups());
		course.setUsers(c.getUsers());
		courseRepository.save(course);
	}
	
	public void deleteCourse(Long id) {
		courseRepository.deleteById(id);
	}
	
}
