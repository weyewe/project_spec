Ext.define('AM.store.Parts', {
	extend: 'Ext.data.Store',
	require : ['AM.model.Part'],
	model: 'AM.model.Part',
	// autoLoad: {start: 0, limit: this.pageSize},
	autoLoad : false, 
	autoSync: false,
	pageSize : 10, 
	
	sorters : [
		{
			property	: 'id',
			direction	: 'DESC'
		}
	], 
	listeners: {

	} 
});
