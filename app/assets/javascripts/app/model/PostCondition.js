Ext.define('AM.model.PostCondition', {
  	extend: 'Ext.data.Model',
  	fields: [
 
		 
		

    	{ name: 'id', type: 'int' },
			{ name: 'phase_id', type: 'int' },
			{ name: 'phase_name', type: 'string' },
			
    	{ name: 'code', type: 'string' } ,
			{ name: 'description', type: 'string' } 
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/post_conditions',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'post_conditions',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { post_condition : record.data };
				}
			}
		}
	
  
});
