Ext.define('AM.store.Groups', {
	extend: 'Ext.data.Store',
	require : ['AM.model.Group'],
	model: 'AM.model.Group',
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
