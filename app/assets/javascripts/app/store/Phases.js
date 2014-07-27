Ext.define('AM.store.Phases', {
	extend: 'Ext.data.Store',
	require : ['AM.model.Phase'],
	model: 'AM.model.Phase',
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
