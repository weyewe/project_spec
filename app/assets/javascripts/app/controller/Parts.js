Ext.define('AM.controller.Parts', {
  extend: 'Ext.app.Controller',

  stores: ['Projects', 'Groups', 'Parts'],
  models: ['Part'],

	selectedParentId1: null, 
	selectedParentId2: null, 
	
  views: [
    'master.part.List',
    'master.part.Form',
		'master.Part',
		'master.ProjectGroupList'
  ],

  	refs: [
		{
			ref : "wrapper",
			selector : "partProcess"
		},
		{
			ref : 'parentList1',
			selector : 'partProcess masterprojectgroupList masterprojectList'
		},
		
		{
			ref : 'parentList2',
			selector : 'partProcess masterprojectgroupList mastergroupList'
		},
		{
			ref: 'list',
			selector: 'partlist'
		},
		{
			ref : 'searchField1',
			selector: 'partProcess masterprojectgroupList masterprojectList textfield[name=searchField]'
		},
		{
			ref : 'searchField2',
			selector: 'partProcess masterprojectgroupList mastergroupList textfield[name=searchField]'
		},
		{
			ref : 'searchField',
			selector: 'partlist textfield[name=searchField]'
		}
	],

  init: function() {
    this.control({
			'partProcess masterprojectgroupList masterprojectList' : {
				afterrender : this.loadParentObjectList1,
				selectionchange: this.parentSelectionChange1,
			},
			
			'partProcess masterprojectgroupList mastergroupList' : {
				selectionchange: this.parentSelectionChange2,
			},
	
      'partlist': {
        itemdblclick: this.editObject,
        selectionchange: this.selectionChange,
				destroy : this.onDestroy
      },

      'partform button[action=save]': {
        click: this.updateObject
      },
      'partlist button[action=addObject]': {
        click: this.addObject
      },
      'partlist button[action=editObject]': {
        click: this.editObject
      },
      'partlist button[action=deleteObject]': {
        click: this.deleteObject
      },
			'groupProcess partlist textfield[name=searchField]': {
        change: this.liveSearch
      },

    });
  },

	loadParentObjectList1 : function(me){
		me.getStore().getProxy().extraParams =  {};
		me.getStore().load(); 
	},
	
	parentSelectionChange1 : function(selectionModel, selections) {
		var me = this; 
    var grid = me.getList();
		var parentList1 = me.getParentList1();
		var parentList2 = me.getParentList2();
		var wrapper = me.getWrapper();
		
		
 
		
		 
		if (parentList.getSelectionModel().hasSelection()) {
			var row = parentList.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			
			if( me.selectedParentId1 !==  id){
				// reload
				grid.getStore().getProxy().extraParams.parent_id =  wrapper.selectedParentId ;
				grid.getStore().load();
				
				grid.getStore().loadData([],false);
				parentList2.getStore().loadData([],false);
			}
			
			
		}
		
		
		
  },
	
 

	onDestroy: function(){
		this.getPartsStore().loadData([],false);
	},

	liveSearch : function(grid, newValue, oldValue, options){
		var me = this;

		me.getPartsStore().getProxy().extraParams = {
		    livesearch: newValue
		};
	 
		me.getProjectsStore().load();
	},
 

	loadObjectList : function(me){
		me.getStore().load();
	},
	
	

  addObject: function() {
	
    
		var parentObject  = this.getParentList().getSelectedObject();
		if( parentObject) {
			var view = Ext.widget('groupform');
			view.show();
			view.setParentData(parentObject);
		}
  },

  editObject: function() {
		var me = this; 
    var record = this.getList().getSelectedObject();
		var parentObject  = this.getParentList().getSelectedObject();
		if( parentObject) {
			var view = Ext.widget('groupform');
			view.show();
			view.setParentData(parentObject);
		}
		
		

    view.down('form').loadRecord(record);
  },

  updateObject: function(button) {
		var me = this; 
    var win = button.up('window');
    var form = win.down('form');
		var parentList = this.getParentList();
		var wrapper = this.getWrapper();

    var store = this.getGroupsStore();
    var record = form.getRecord();
    var values = form.getValues();

		if( record ){
			record.set( values );
			 
			form.setLoading(true);
			record.save({
				success : function(record){
					form.setLoading(false);
					
					store.load({
						params: {
							parent_id : wrapper.selectedParentId 
						}
					});
					 
					
					win.close();
				},
				failure : function(record,op ){
					form.setLoading(false);
					var message  = op.request.scope.reader.jsonData["message"];
					var errors = message['errors'];
					form.getForm().markInvalid(errors);
					this.reject();
				}
			});
				
			 
		}else{
			//  no record at all  => gonna create the new one 
			var me  = this; 
			var newObject = new AM.model.Group( values ) ;
			
			// learnt from here
			// http://www.sencha.com/forum/showthread.php?137580-ExtJS-4-Sync-and-success-failure-processing
			// form.mask("Loading....."); 
			form.setLoading(true);
			newObject.save({
				success: function(record){
	
					store.load({
						params: {
							parent_id : wrapper.selectedParentId 
						}
					});
					
					form.setLoading(false);
					win.close();
					
				},
				failure: function( record, op){
					form.setLoading(false);
					var message  = op.request.scope.reader.jsonData["message"];
					var errors = message['errors'];
					form.getForm().markInvalid(errors);
					this.reject();
				}
			});
		} 
  },

  deleteObject: function() {
    var record = this.getList().getSelectedObject();

    if (record) {
      var store = this.getGroupsStore();
      store.remove(record);
      store.sync();
// to do refresh programmatically
			this.getList().query('pagingtoolbar')[0].doRefresh();
    }

  },

  selectionChange: function(selectionModel, selections) {
    var grid = this.getList();
  
    if (selections.length > 0) {
      grid.enableRecordButtons();
    } else {
      grid.disableRecordButtons();
    }
  },



	

});