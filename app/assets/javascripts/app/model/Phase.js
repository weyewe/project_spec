Ext.define('AM.model.Phase', {
  	extend: 'Ext.data.Model',
  	fields: [
 

    	{ name: 'id', type: 'int' },
			{ name: 'part_id', type: 'int' },
			{ name: 'part_name', type: 'string' },
			
    	{ name: 'code', type: 'string' } ,
			{ name: 'name', type: 'string' } ,
			{ name: 'description', type: 'string' }
			
    
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/phases',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'phases',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { phase : record.data };
				}
			}
		}
	
  
});
