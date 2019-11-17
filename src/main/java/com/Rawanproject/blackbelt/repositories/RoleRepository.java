package com.Rawanproject.blackbelt.repositories;

import java.util.List;
import org.springframework.data.repository.CrudRepository;
import com.Rawanproject.blackbelt.models.Role;


public interface RoleRepository extends CrudRepository<Role, Long>{
	List<Role> findAll();
	Role findByType(String type);}
