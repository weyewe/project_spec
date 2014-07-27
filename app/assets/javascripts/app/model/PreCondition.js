Ext.define('AM.model.PreCondition', {
  	extend: 'Ext.data.Model',
  	fields: [
  

    	{ name: 'id', type: 'int' },
			{ name: 'phase_id', type: 'int' },
			{ name: 'phase_name', type: 'string' },
			
    	{ name: 'code', type: 'string' } ,
			{ name: 'description', type: 'string' } 
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/pre_conditions',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'pre_conditions',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { pre_condition : record.data };
				}
			}
		}
	
  
});
