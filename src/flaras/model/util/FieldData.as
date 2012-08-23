package flaras.model.util 
{
	public class FieldData 
	{
		private var _name:String;
		private var _value:String;
	
		public function FieldData(pName:String, pValue:String) 
		{
			this._name = pName;
			this._value = pValue;
		}
		
		public function getName():String 
		{
			return _name;
		}
		
		public function getValue():String 
		{
			return _value;
		}		
	}

}