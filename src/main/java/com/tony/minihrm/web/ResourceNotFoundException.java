package com.tony.minihrm.web;

public class ResourceNotFoundException extends RuntimeException {

	private Long resourceID;

	public ResourceNotFoundException(Long id) {
		this.resourceID = id;
	}

}
