package com.Rawanproject.blackbelt.repositories;



import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.Rawanproject.blackbelt.models.User;
@Repository
public interface UserRepository extends CrudRepository<User, Long>{
	User findByEmail(String email);
//	List <User> findAllByCoursesEquals(Course course);
}
