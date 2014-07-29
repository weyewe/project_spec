Ext.define('AM.controller.Projects', {
  extend: 'Ext.app.Controller',

  stores: ['Projects'],
  models: ['Project'],

  views: [
    'master.project.List',
    'master.project.Form'
  ],

  	refs: [
		{
			ref: 'list',
			selector: 'projectlist'
		} 
	],

  init: function() {
	console.log("Initializing projects controler");
    this.control({
      'projectlist': {
        itemdblclick: this.editObject,
        selectionchange: this.selectionChange,
				afterrender : this.loadObjectList,
      },
      'projectform button[action=save]': {
        click: this.updateObject
      },
      'projectlist button[action=addObject]': {
        click: this.addObject
      },
      'projectlist button[action=editObject]': {
        click: this.editObject
      },
      'projectlist button[action=deleteObject]': {
        click: this.deleteObject
			}	,
			
			'projectlist button[action=downloadPDF]': {
        click: this.downloadPDF
			}	,
			
			'projectlist textfield[name=searchField]': {
				change: this.liveSearch
			}
		
    });
  },

	downloadPDF: function(){
		var record = this.getList().getSelectedObject();
		
		if(!record){return;}
		var ps_width = 380; 
		var ps_height = 550; 
		var id = record.get("id")
		
		// var anotherwindow = window.open(
		// 	'reports/billofsale.php?id='+id,'PDF','width='+ps_width+',height='+ps_height+',resizable');
			// var anotherwindow = window.open(
			// 	'projects/'+id,
			// 	'PDF',
			// 	'width='+ps_width+',height='+ps_height+',resizable');
			// 	
		
			var anotherwindow = window.open(
				'projects_pdf/'+id + ".pdf" );				
				
		// window.open( '/bookings/payment_receipt/'+ record.get('id')  );
	},
	
	

	liveSearch : function(grid, newValue, oldValue, options){
		var me = this;

		me.getProjectsStore().getProxy().extraParams = {
		    livesearch: newValue
		};
	 
		me.getProjectsStore().load();
	},
 

	loadObjectList : function(me){
		console.log("************* IN THE Projects CONTROLLER: afterRENDER");
		me.getStore().load();
	},

  addObject: function() {
    var view = Ext.widget('projectform');
    view.show();
  },

  editObject: function() {
    var record = this.getList().getSelectedObject();
    var view = Ext.widget('projectform');

    view.down('form').loadRecord(record);
		view.setComboBoxData(record); 
  },

  updateObject: function(button) {
    var win = button.up('window');
    var form = win.down('form');

    var store = this.getProjectsStore();
    var record = form.getRecord();
    var values = form.getValues();

		
		if( record ){
			record.set( values );
			 
			form.setLoading(true);
			record.save({
				success : function(record){
					form.setLoading(false);
					//  since the grid is backed by store, if store changes, it will be updated
					store.load();
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
			var newObject = new AM.model.Project( values ) ;
			
			// learnt from here
			// http://www.sencha.com/forum/showthread.php?137580-ExtJS-4-Sync-and-success-failure-processing
			// form.mask("Loading....."); 
			form.setLoading(true);
			newObject.save({
				success: function(record){
					//  since the grid is backed by store, if store changes, it will be updated
					store.load();
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
      var store = this.getProjectsStore();
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
  }

});
