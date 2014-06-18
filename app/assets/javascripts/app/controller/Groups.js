Ext.define('AM.controller.Groups', {
  extend: 'Ext.app.Controller',

  stores: ['Projects', 'Groups'],
  models: ['Group'],

  views: [
    'master.project.List',
    'master.project.Form',
		'master.Group',
		'master.ProjectList'
  ],

  	refs: [
		{
			ref : "wrapper",
			selector : "groupProcess"
		},
		{
			ref : 'parentList',
			selector : 'groupProcess masterprojectList'
		},
		{
			ref: 'list',
			selector: 'grouplist'
		},
		{
			ref : 'searchField',
			selector: 'grouplist textfield[name=searchField]'
		}
	],

  init: function() {
    this.control({
			'groupProcess masterprojectList' : {
				afterrender : this.loadParentObjectList,
				selectionchange: this.parentSelectionChange,
			},
	
      'grouplist': {
        itemdblclick: this.editObject,
        selectionchange: this.selectionChange,
				destroy : this.onDestroy
				// afterrender : this.loadObjectList,
      },
      'groupform button[action=save]': {
        click: this.updateObject
      },
      'grouplist button[action=addObject]': {
        click: this.addObject
      },
      'grouplist button[action=editObject]': {
        click: this.editObject
      },
      'grouplist button[action=deleteObject]': {
        click: this.deleteObject
      },
			'groupProcess masterprojectList textfield[name=searchField]': {
        change: this.liveSearch
      },


		
    });
  },
	onDestroy: function(){
		this.getGroupsStore().loadData([],false);
	},

	liveSearch : function(grid, newValue, oldValue, options){
		var me = this;

		me.getProjectsStore().getProxy().extraParams = {
		    livesearch: newValue
		};
	 
		me.getProjectsStore().load();
	},
 

	loadObjectList : function(me){
		me.getStore().load();
	},
	
	loadParentObjectList: function(me){
		me.getStore().getProxy().extraParams =  {};
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



	parentSelectionChange: function(selectionModel, selections) {
		var me = this; 
    var grid = me.getList();
		var parentList = me.getParentList();
		var wrapper = me.getWrapper();
		
		

    if (selections.length > 0) {
			grid.enableAddButton();
    } else {
			grid.disableAddButton();
    }
		
		 
		if (parentList.getSelectionModel().hasSelection()) {
			var row = parentList.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			wrapper.selectedParentId = id ; 
		}
		
		
		grid.getStore().getProxy().extraParams.parent_id =  wrapper.selectedParentId ;
		grid.getStore().load(); 
  },

});
