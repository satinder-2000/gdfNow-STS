package org.gdf.repository;

import org.gdf.model.Country;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

public interface CountryRepository extends CrudRepository<Country, Integer> {
	
	@Query("SELECT c FROM Country c WHERE c.code = ?1")
	public Country findByCode(String countryCode);

}
