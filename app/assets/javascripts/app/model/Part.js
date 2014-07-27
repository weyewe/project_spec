Ext.define('AM.model.Part', {
  	extend: 'Ext.data.Model',
  	fields: [
 

    	{ name: 'id', type: 'int' },
			{ name: 'group_id', type: 'int' },
			{ name: 'group_name', type: 'string' },
			
    	{ name: 'code', type: 'string' } ,
			{ name: 'name', type: 'string' } ,
			{ name: 'description', type: 'string' }
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/parts',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'parts',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { part : record.data };
				}
			}
		}
	
  
});
