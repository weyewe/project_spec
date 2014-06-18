Ext.define('AM.model.Group', {
  	extend: 'Ext.data.Model',
  	fields: [
 

    	{ name: 'id', type: 'int' },
			{ name: 'project_id', type: 'int' },
			
    	{ name: 'code', type: 'string' } ,
			{ name: 'name', type: 'string' } ,
			{ name: 'description', type: 'string' }
  	],

	 


   
  	idProperty: 'id' ,proxy: {
			url: 'api/groups',
			type: 'rest',
			format: 'json',

			reader: {
				root: 'groups',
				successProperty: 'success',
				totalProperty : 'total'
			},

			writer: {
				getRecordData: function(record) {
					return { group : record.data };
				}
			}
		}
	
  
});
