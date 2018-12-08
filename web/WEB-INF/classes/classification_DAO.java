package project_army;

public class classification_DAO {
	private String item_name;
	private int item_no;
	private int item_up_no;
	
	public classification_DAO(String name,int no){
		this.item_name = name;
		this.item_no = no;
	}
	public classification_DAO(String name,int no, int up_no){
		this.item_name = name;
		this.item_no = no;
		this.item_up_no = no;
	}
	public String getName() {
		return this.item_name;
	}
	public int getNo() { return this.item_no; }
	public int getItem_up_no() { return this.item_no; }

}
