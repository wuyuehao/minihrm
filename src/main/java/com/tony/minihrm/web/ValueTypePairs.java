package com.tony.minihrm.web;

public class ValueTypePairs {

	Object value;
	Class<?> type;
	
	public ValueTypePairs(String value, Class<?> type){
		this.value=value;
		this.type=type;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
	public Class<?> getType() {
		return type;
	}
	public void setType(Class<?> type) {
		this.type = type;
	}
}
