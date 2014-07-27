Ext.define('AM.store.PostConditions', {
	extend: 'Ext.data.Store',
	require : ['AM.model.PostCondition'],
	model: 'AM.model.PostCondition',
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
