package homework;

public class MembershipDTO {
	private String user_id; 
	private String pass;  
	private String name;  
	private String gender;   
	private String birthday; 
	private String zipcode;  
	private String address1; 
	private String address2; 
	private String email;  
	private String mobile;  
	private String tel;   
	private String regidate;
	public MembershipDTO() {}
	public MembershipDTO(String user_id, String pass, String name, String gender, String birthday, String zipcode,
			String address1, String address2, String email, String mobile, String tel, String regidate) {
		super();
		this.user_id = user_id;
		this.pass = pass;
		this.name = name;
		this.gender = gender;
		this.birthday = birthday;
		this.zipcode = zipcode;
		this.address1 = address1;
		this.address2 = address2;
		this.email = email;
		this.mobile = mobile;
		this.tel = tel;
		this.regidate = regidate;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getBirthday() {
		return birthday;
	}
	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getRegidate() {
		return regidate;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
}
