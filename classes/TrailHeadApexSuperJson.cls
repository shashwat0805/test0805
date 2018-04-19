public class TrailHeadApexSuperJson{
	public cls_attachments[] attachments;
	class cls_attachments {
		public String iid;	//55d66226726b611100aaf741
		public boolean replacement;
		public Integer quantity;	//5
		public String name;	//Generator 1000 kW
		public Integer maintenanceperiod;	//365
		public Integer lifespan;	//120
		public Integer cost;	//5000
		public String sku;	//100003
	}
	public static TrailHeadApexSuperJson parse(String json){
		return (TrailHeadApexSuperJson) System.JSON.deserialize(json, TrailHeadApexSuperJson.class);
	}
	/*
	static testMethod void testParse() {
		String json = '[{"_id":"55d66226726b611100aaf741","replacement":false,"quantity":5,"name":"Generator 1000 kW","maintenanceperiod":365,"lifespan":120,"cost":5000,"sku":"100003"}]';
		TrailHeadApexSuperJson obj = parse(json);
		System.assert(obj != null);
	}
	*/
}