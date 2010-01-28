package
{
	[Bindable]
	public class CustomerVO
	{
		public var customerID:int;
		public var fname:String;
		public var lname:String;
		public var address:String;
		public var city:String;
		public var state:String;
		public var zip:String;
		public var phone:String;
		public var email:Date;
		public var updateDate:Date;
		
		public function CustomerVO(customerID:int = 0, fname:String = "", lname:String = "", address:String = "", 
		city:String = "", state:String = "", zip:String = "", phone:String = "", email:Date = null, updateDate:Date = null)
		{
			this.customerID = customerID;
			this.fname = fname;
			this.lname = lname;
			this.address = address;
			this.city = city;
			this.state = state;
			this.zip = zip;
			this.phone = phone;
			this.email = email;
			this.updateDate = updateDate;		
		}
	}
}