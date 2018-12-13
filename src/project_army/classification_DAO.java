package project_army;

public class classification_DAO {
	private String item_name;
	private int item_no;
	private int item_up_no;
	private String item_number;
	private String item_detail;
	
	public classification_DAO(String name,int no, int up_no){
		this.item_name = name;
		this.item_no = no;
		this.item_up_no = up_no;
	}
	public classification_DAO(String name,int no){
		this.item_name = name;
		this.item_no = no;
	}
	public classification_DAO(String name, String no){
		this.item_name = name;
		this.item_number = no;
	}
	public classification_DAO(String name, String no, String detail){
		this.item_name = name;
		this.item_number = no;
		this.item_detail = detail;
	}
	public String getName() {
		return this.item_name;
	}
	public String getNumber() {
		return this.item_number;
	}
	public String getDetail() {
		return this.item_detail;
	}
	public int getNo() { return this.item_no; }
	public int getUpNo() { return this.item_up_no; }
}
