Ext.define('AM.store.PreConditions', {
	extend: 'Ext.data.Store',
	require : ['AM.model.PreCondition'],
	model: 'AM.model.PreCondition',
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
