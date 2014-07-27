Ext.define('AM.controller.Parts', {
  extend: 'Ext.app.Controller',

  stores: ['Projects', 'Groups', 'Parts', 'Phases', 'PreConditions', 'PostConditions'],
  models: ['Part'],

	selectedParentId1: null, 
	selectedParentId2: null, 
	selectedParentId3: null , 
	selectedParentId4 : null, 
	
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
			ref: 'phaseList',
			selector: 'phaselist'
		},
		
		{
			ref: 'preConditionList',
			selector: 'preconditionlist'
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

			'phaselist': {
        itemdblclick: this.editPhaseObject,
        selectionchange: this.selectionChangePhase,
				destroy : this.onDestroyPhase
      },

      'phaseform button[action=save]': {
        click: this.updatePhaseObject
      },
      'phaselist button[action=addObject]': {
        click: this.addPhaseObject
      },
      'phaselist button[action=editObject]': {
        click: this.editPhaseObject
      },
      'phaselist button[action=deleteObject]': {
        click: this.deletePhaseObject
      } ,

//  for the pre condition
			'preconditionlist': {
        itemdblclick: this.editPreConditionObject,
        selectionchange: this.selectionChangePreCondition,
				destroy : this.onDestroyPreCondition
      },

      'preconditionform button[action=save]': {
        click: this.updatePreConditionObject
      },
      'preconditionlist button[action=addObject]': {
        click: this.addPreConditionObject
      },
      'preconditionlist button[action=editObject]': {
        click: this.editPreConditionObject
      },
      'preconditionlist button[action=deleteObject]': {
        click: this.deletePreConditionObject
      }

// for the post condition

    });
  },

	loadParentObjectList1 : function(me){
		var currentController = this; 
		
		var parentList1 = currentController.getParentList1();
		var parentList2 = currentController.getParentList2();
		var grid = currentController.getList();
		
		currentController.selectedParentId1 = null;
		currentController.selectedParentId2 = null;
		currentController.selectedParentId3 = null;
		
		
		me.getStore().getProxy().extraParams =  {};
		me.getStore().load(); 
		
		grid.getStore().loadData([],false);
		parentList2.getStore().loadData([],false);
	},
	
	parentSelectionChange1 : function(selectionModel, selections) {
		var me = this; 
    var grid = me.getList();
		var phaseList = me.getPhaseList();
		var parentList1 = me.getParentList1();
		var parentList2 = me.getParentList2();
		var wrapper = me.getWrapper();
		
		if (parentList1.getSelectionModel().hasSelection()) {
			var row = parentList1.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			
			if( me.selectedParentId1 !==  id){
				me.selectedParentId1 = id; 
				// reload
				grid.getStore().loadData([],false);
				phaseList.getStore().loadData([], false);
				parentList2.getStore().getProxy().extraParams.parent_id =  id  ;
				parentList2.getStore().load();
				
				// disable all buttons on grid
				grid.disableRecordButtons();
				grid.disableAddButton();
				phaseList.disableRecordButtons();
				phaseList.disableAddButton();
			}
		}
  },

	parentSelectionChange2 : function(selectionModel, selections) {
		var me = this; 
    var grid = me.getList();
		var parentList1 = me.getParentList1();
		var parentList2 = me.getParentList2();
		var phaseList = me.getPhaseList(); 
		var wrapper = me.getWrapper();
		
		if (parentList2.getSelectionModel().hasSelection()) {
			// reload 
			var row = parentList2.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			
			if( me.selectedParentId2 !==  id){
				me.selectedParentId2 = id; 
				
				grid.getStore().getProxy().extraParams.parent_id =  id  ;
				grid.getStore().load();
				phaseList.getStore().loadData([], false);
			}
			
			// enable add button 
			grid.enableAddButton();
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
	
    
		var parentObject1  = this.getParentList1().getSelectedObject();
		var parentObject2  = this.getParentList2().getSelectedObject();
		
		if( parentObject1 && parentObject2 ) {
			var view = Ext.widget('partform');
			
			view.show();
			
			view.setParentData1(parentObject1);
			view.setParentData2(parentObject2);
		}
  },

  editObject: function() {
		var me = this; 
    var record = this.getList().getSelectedObject();
		var parentObject1  = this.getParentList1().getSelectedObject();
		var parentObject2  = this.getParentList1().getSelectedObject();
		
		if( record ) {
			var view = Ext.widget('partform');
			view.show();
			view.setParentData1(parentObject1);
			view.setParentData2(parentObject2);
		}
		
		

    view.down('form').loadRecord(record);
  },

  updateObject: function(button) {
		var me = this; 
    var win = button.up('window');
    var form = win.down('form');
		var parentList1 = this.getParentList1();
		var wrapper = this.getWrapper();

    var store = this.getPartsStore();
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
							parent_id : me.selectedParentId2
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
			var newObject = new AM.model.Part( values ) ;
			
			// learnt from here
			// http://www.sencha.com/forum/showthread.php?137580-ExtJS-4-Sync-and-success-failure-processing
			// form.mask("Loading....."); 
			form.setLoading(true);
			newObject.save({
				success: function(record){
	
					store.load({
						params: {
							parent_id : me.selectedParentId2 
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
      var store = this.getPartsStore();
      store.remove(record);
      store.sync();
// to do refresh programmatically
			this.getList().query('pagingtoolbar')[0].doRefresh();
    }

  },

  selectionChange: function(selectionModel, selections) {
		var me = this; 
    var childList = me.getPhaseList();
		var grid = me.getList();
		
		var wrapper = me.getWrapper();
		
		if (grid.getSelectionModel().hasSelection()) {
			// reload 
			var row = grid.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			
			if( me.selectedParentId3 !==  id){
				me.selectedParentId3 = id; 
				
				childList.getStore().getProxy().extraParams.parent_id =  id  ;
				childList.getStore().load();
			}
			
			// enable add button 
			childList.enableAddButton();
			grid.enableRecordButtons();
		}else{
			
			grid.disableRecordButtons();
			childList.disableAddButton();
		}
		 
  },




/*

	For the phase
	
	'phaselist': {
    itemdblclick: this.editPhaseObject,
    selectionchange: this.selectionChangePhase,
		destroy : this.onDestroyPhase
  },

  'phaseform button[action=save]': {
    click: this.updatePhaseObject
  },
  'phaselist button[action=addObject]': {
    click: this.addPhaseObject
  },
  'phaselist button[action=editObject]': {
    click: this.editPhaseObject
  },
  'phaselist button[action=deleteObject]': {
    click: this.deletePhaseObject
  }

*/

	onDestroyPhase: function(){
		this.getPhasesStore().loadData([],false);
	},

	  



	addPhaseObject: function() {

		
		var parentObject = this.getList().getSelectedObject(); 
	
		if( parentObject ) {
			var view = Ext.widget('phaseform');
		
			view.show();
		
			view.setParentData(parentObject);
			
		}
	},

	editPhaseObject: function() {
		var me = this; 
	  var record = this.getPhaseList().getSelectedObject();
		var parentObject  = this.getList().getSelectedObject(); 
	
		if( record  &&  parentObject) {
			var view = Ext.widget('phaseform');
			view.show();
			view.setParentData(parentObject); 
		}
	
	

	  view.down('form').loadRecord(record);
	},

	updatePhaseObject: function(button) {
		var me = this; 
	  var win = button.up('window');
	  var form = win.down('form');
		var parentList = this.getList();
		var wrapper = this.getWrapper();

	  var store = this.getPhasesStore();
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
							parent_id : me.selectedParentId3
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
			var newObject = new AM.model.Phase( values ) ;
		
			// learnt from here
			// http://www.sencha.com/forum/showthread.php?137580-ExtJS-4-Sync-and-success-failure-processing
			// form.mask("Loading....."); 
			form.setLoading(true);
			newObject.save({
				success: function(record){

					store.load({
						params: {
							parent_id : me.selectedParentId3 
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

	deletePhaseObject: function() {
	  var record = this.getPhaseList().getSelectedObject();

	  if (record) {
	    var store = this.getPhasesStore();
	    store.remove(record);
	    store.sync();
	// to do refresh programmatically
			this.getPhaseList().query('pagingtoolbar')[0].doRefresh();
	  }

	},

	selectionChangePhase: function(selectionModel, selections) {
	  // var grid = this.getPhaseList();
	  // 
	  // if (selections.length > 0) {
	  //   grid.enableRecordButtons();
	  // } else {
	  //   grid.disableRecordButtons();
	  // }
	
		var me = this; 
    var childList = me.getPreConditionList();
		var grid = me.getPhaseList();
		
		var wrapper = me.getWrapper();
		
		if (grid.getSelectionModel().hasSelection()) {
			// reload 
			var row = grid.getSelectionModel().getSelection()[0];
			var id = row.get("id"); 
			
			if( me.selectedParentId4 !==  id){
				me.selectedParentId4 = id; 
				
				childList.getStore().getProxy().extraParams.parent_id =  id  ;
				childList.getStore().load();
			}
			
			// enable add button 
			childList.enableAddButton();
			grid.enableRecordButtons();
		}else{
			
			grid.disableRecordButtons();
			childList.disableAddButton();
		}
	
	
	
	},
	
	
/*
	For the pre condition
*/

	onDestroyPreCondition: function(){
		this.getPreConditionsStore().loadData([],false);
	},

	  



	addPreConditionObject: function() {

		
		var parentObject = this.getPhaseList().getSelectedObject(); 
	
		if( parentObject ) {
			var view = Ext.widget('preconditionform');
		
			view.show();
		
			view.setParentData(parentObject);
			
		}
	},

	editPreConditionObject: function() {
		var me = this; 
	  var record = this.getPreConditionList().getSelectedObject();
		var parentObject  = this.getPhaseList().getSelectedObject(); 
	
		if( record  &&  parentObject) {
			var view = Ext.widget('preconditionform');
			view.show();
			view.setParentData(parentObject); 
		}
	
	

	  view.down('form').loadRecord(record);
	},

	updatePreConditionObject: function(button) {
		var me = this; 
	  var win = button.up('window');
	  var form = win.down('form');
		var parentList = this.getPhaseList();
		var wrapper = this.getWrapper();

	  var store = this.getPreConditionsStore();
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
							parent_id : me.selectedParentId4
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
			var newObject = new AM.model.PreCondition( values ) ;
		
			// learnt from here
			// http://www.sencha.com/forum/showthread.php?137580-ExtJS-4-Sync-and-success-failure-processing
			// form.mask("Loading....."); 
			form.setLoading(true);
			newObject.save({
				success: function(record){

					store.load({
						params: {
							parent_id : me.selectedParentId4
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

	deletePreConditionObject: function() {
	  var record = this.getPreConditionList().getSelectedObject();

	  if (record) {
	    var store = this.getPreConditionsStore();
	    store.remove(record);
	    store.sync();
	// to do refresh programmatically
			this.getPreConditionList().query('pagingtoolbar')[0].doRefresh();
	  }

	},

	selectionChangePreCondition: function(selectionModel, selections) {
	  var grid = this.getPreConditionList();

	  if (selections.length > 0) {
	    grid.enableRecordButtons();
	  } else {
	    grid.disableRecordButtons();
	  }
	},

	

});
