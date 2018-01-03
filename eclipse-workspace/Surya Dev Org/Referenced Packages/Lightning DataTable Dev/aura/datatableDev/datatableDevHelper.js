({
    timeoutRef:null,
    filterRowBySearchTxt : function(cmp,searchTxt) {
        var columsToSearch = [],
            searchInCol = cmp.get("v.searchByCol"),
            _columns = cmp.get("v._columns") || [],
            rows = cmp.get("v.dataRows");

        var dateFormatTime = 'D-MMM-YYYY HH:mm A',
            dateFormat = 'D-MMM-YYYY',
            timezone = this.getTimeZone();

        for(var i = 0;i < _columns.length;i++){
            if(_columns[i].type === 'date' && _columns[i].format){
                dateFormat = _columns[i].format;
            }
            
            if(_columns[i].type === 'datetime' && _columns[i].format){
                dateFormatTime = _columns[i].format;
            }
            
            if(searchInCol){
                if(_columns[i].name === searchInCol){
                    columsToSearch.push(_columns[i]);
                    break;
                }
            }
            else{
                columsToSearch.push(_columns[i]);
            }
        }

        return _.filter(rows, function(row) {
            var hasFound = false;

            for(var i = 0;i < columsToSearch.length;i++){
                var column = columsToSearch[i].name,
                    type = columsToSearch[i].type;
                var value = _.get(row,column);

                if(value){
                    if(type === 'date' || type === 'datetime'){
                        if(type === 'date'){
                            value = moment.tz(value,timezone).format(dateFormat);
                        }
                        else if(type === 'datetime'){
                            value = moment.tz(value,timezone).format(dateFormatTime);
                        }
                    }
                    if(!hasFound){
                        hasFound = value.toString().toLowerCase().indexOf(searchTxt.toLowerCase()) !== -1;
                        if(hasFound){
                            break;
                        }
                    }
                } 
            }

            return hasFound;
        });
    },
    initializeTable : function(cmp,event,helper,rows){
        var columns = cmp.get("v.header") || [],
            _columns = cmp.get("v._columns") || [],
            itemsPerPage = [10,25,50];
            

        // set limit dropdown options and set columns based on column attribute
        var opts = [];
        for(var i = 0;i < itemsPerPage.length;i++){
            var opt = {label: itemsPerPage[i] , value: itemsPerPage[i]};
            
            if(i === 0){
                opt.selected =  true;
            }
            
            opts.push(opt);
        }
        cmp.find("itemsPerPage").set("v.options", opts);
        

        helper.updateLimit(cmp);

        // Convert column to a general format [{'label':'','value':''}]
        if(columns.length){
            var columnWrapper = [];

            for(var i = 0;i < columns.length;i++){
                columnWrapper.push(columns[i]);
            }

            cmp.set("v._columns",columnWrapper);
            _columns = columnWrapper;
            
            helper.showDtTable(cmp);
            var tableCmp = cmp.find("dtTable");
            
            if($A.util.hasClass(tableCmp,'slds-hide')){
                $A.util.removeClass(tableCmp,'slds-hide');
            }
            
            var initConfig = cmp.get("v.initConfig");
            var columnObj = _columns[0];
            var sortOrder;
            if(Array.isArray(initConfig.order) && initConfig.order.length){
                var index = initConfig.order[0];
                sortOrder = initConfig.order[1];
                columnObj = _columns[index];
            }
            
            // timeout to workaround the cmp.find() error in dtColumn as done:rendering not working
            window.setTimeout(
                $A.getCallback(function() {
                    if (cmp.isValid() && _columns[0]) {
                        helper.sortByColumn(cmp, event, helper,columnObj,sortOrder);
                    }
                }),100
            );
        }   
        else {
            $A.util.addClass(tableCmp,'slds-hide');
        }
       
        cmp.set("v.reRender",true); 
    },
    sortByColumn : function(cmp,event,helper,defaultSortColumn,defaultSortOrder){
        var columnToSort = event.getParam("columnToSort") || defaultSortColumn,
            sortColumn = cmp.get("v.sortColumn"),
            sortOrder = cmp.get("v.sortOrder"),
            rows = cmp.get("v.dataRows"),
            offset = cmp.get("v.offset"),
            limit = cmp.get("v.limit"),
            searchTxt = cmp.get("v.searchTxt"),
            _rows;
		
        if(defaultSortColumn){
            columnToSort = defaultSortColumn;
            sortOrder = defaultSortOrder || 'asc';
        } else {
           // if order is asc flip to desc, and vice-verse
            if(columnToSort.name === sortColumn.name){
                sortOrder = (sortOrder === 'desc') ? 'asc' : 'desc';
            }
            else{
                sortOrder = 'asc';
            } 
        }
        
        // reset offset when sorting is done
        offset = 0;
        sortColumn.label = columnToSort.label;
        sortColumn.name = columnToSort.name;

        //Always use the filtered row, if search has been done earlier
        if(searchTxt){
            rows = cmp.get("v._rows");
        }

        cmp.set("v.offset",offset);
        cmp.set("v.sortColumn",sortColumn);
        cmp.set("v.sortOrder",sortOrder);
        helper.renderRows(cmp,event,helper,rows,true);

        //Fire event to signal sorting is done
        $A.get("e.ldt:doneSortingColumn").fire();
    },
    filterAndRenderRowsIfNecessary : function(cmp,event,helper){
        var searchTxt = cmp.get("v.searchTxt");
        var rows;
        
        if(searchTxt){
            cmp.set("v.offset",0);
            rows = helper.filterRowBySearchTxt(cmp,searchTxt);
        }
        else{
            rows = cmp.get("v.dataRows");
        }
        
        helper.renderRows(cmp,event,helper,rows,true);
    },
    renderRows : function(cmp,event,helper,rows,needToSortRows){
        var _rows,
            _columns = cmp.get("v._columns"),
            offset = cmp.get("v.offset"),
            limit = cmp.get("v.limit"),
            sortColumn = cmp.get("v.sortColumn"),
            sortOrder = cmp.get("v.sortOrder"),
            searchTxt = cmp.get("v.searchTxt");
		
            var sortFn = function (row) { 
                var value = _.get(row,sortColumn.name);
                var type = typeof value;
                if(type === 'undefined'){
                    return; 
                } else if(type === 'string'){
                    return value.toLowerCase(); 
                } else {
                    return value;
                }
            };
        
        if(needToSortRows){
            if(sortOrder === 'desc'){
                _rows = _.sortBy(rows,sortFn).reverse();
            }
            else{
                _rows = _.sortBy(rows,sortFn);
            }
            cmp.set("v._rows",_rows);
        }
        else{
            _rows = rows;
        }

        //empty and set to solve the initial sorting issue
        cmp.set("v.rowsToDisplay",[]);
        cmp.set("v.rowsToDisplay",_.slice(_rows,offset,offset+limit));
        cmp.set("v.reRender",true);
    },
    showDtTable : function(cmp){
        window.setTimeout(
            $A.getCallback(function() {
                if (cmp.isValid()) {
                    cmp.set("v.showDtView", true);
                }
            }),500
        );
    },
    updateLimit : function(cmp){
        var limit = cmp.find("itemsPerPage").get("v.value");
        
        //convert limit to number to set private attribute
        if(typeof limit === 'string'){
            limit = Number(limit);
        }
        else{
            limit = cmp.get("v.limit");
        }
        
        cmp.set("v.offset",0);
        cmp.set("v.limit",limit);            
    },
    navigateToDetailRecord : function(event){
        var navEvt = $A.get("e.force:navigateToSObject");
        var recordId = event.currentTarget.getAttribute('data-recordid');
        if(navEvt){
            navEvt.setParams({
                "recordId": recordId
            });
            navEvt.fire();
        }
        else{
            window.location.href = "/one/one.app#/sObject/"+recordId+"/view";
        }
    },
    toggleRowSelection : function(cmp,event){
        var rowIndex = event.currentTarget.getAttribute('data-rowindex');
        var rowsToDisplay = cmp.get("v.rowsToDisplay");
        var selectedRows = cmp.get("v.selectedRows");
        var unSelectedRows = cmp.get("v.unSelectedRows");
        var row = rowsToDisplay[rowIndex];
        var rowIdx1 = selectedRows.indexOf(row);
        var rowIdx2 = unSelectedRows.indexOf(row);

        if(event.currentTarget.checked){
            //Add to selected collection if checked
            if(rowIdx1 === -1){
                selectedRows.push(row);
            }

            //Remove it from unselected collection
            if(rowIdx2 > -1){
                unSelectedRows.splice(rowIdx2,1);
            }
        }
        else {
            //Remove it from selected collection if unchecked
            if(rowIdx1 > -1){
                selectedRows.splice(rowIdx1,1);
            }

            //Add to unselected collection if unchecked
            if(rowIdx2 === -1){
                unSelectedRows.push(row);
            }
        }

        cmp.set("v.unSelectedRows",unSelectedRows);
        cmp.set("v.selectedRows",selectedRows);
    },
    fireDTActionClick : function(cmp,row,event){
        var dtActionEvt = cmp.getEvent("dtActionClick"),
            actionId = event.currentTarget.getAttribute('id').split('-')[0],
            params = {
                "actionId":actionId
            };

        if(row){
            params['row'] = row;
            params['index'] = cmp.get("v.dataRows").indexOf(row);
        }
        
        dtActionEvt.setParams(params);
        dtActionEvt.fire();
    },
    generateRow : function(cmp,actualRows,row,columns,config,rowIdx,selectedRows,unselectedRows,selectAll){
        var trNode = document.createElement("tr");
        var rowIndex = actualRows.indexOf(row);

        var tdFragments = document.createDocumentFragment();

        if(config){
            tdFragments.appendChild(this.generateActionCell(cmp,row,config,rowIdx,selectedRows,unselectedRows,selectAll));
        }

        for(var j = 0; j < columns.length;j++){
            tdFragments.appendChild(this.generateDataCell(row,columns[j],config,rowIdx));
        }

        trNode.appendChild(tdFragments);

        return trNode;
    },
    generateActionCell : function(cmp,row,config,rowIdx,selectedRows,unselectedRows,selectAll){
        var tdActionFragments = document.createDocumentFragment();
        var self = this;
        
        if(config.massSelect){
            var tdNode = document.createElement("td");
            var chkObj = this.generateCheckbox('selectall-'+rowIdx);
            var chkHolderNode = chkObj.parentNode;
            var checkboxNode = chkObj.checkboxNode;
            
            checkboxNode.setAttribute('data-rowindex',rowIdx);

            if(unselectedRows.indexOf(row) > -1){
                checkboxNode.checked = false;
            }
            else if(selectedRows.indexOf(row) > -1){
                checkboxNode.checked = true;
            }

            tdNode.appendChild(chkHolderNode);

            //Add listner to toggle the selected property
            checkboxNode.addEventListener("change",$A.getCallback(function(evt){
                self.toggleRowSelection(cmp,evt);
            }));

            tdActionFragments.appendChild(tdNode);
        }

        if(config.rowAction){
            var tdNode = document.createElement("td");
            for(var i = 0;i < config.rowAction.length;i++){
                var actionNode;
                var rowAction = config.rowAction[i];

                //add actions only if `id` is present
                if(rowAction.id){
                    if(rowAction.type === 'button'){
                        actionNode = document.createElement('button');
                        actionNode.type = 'button';
                        actionNode.className  = (rowAction.class ? rowAction.class : 'slds-button slds-button--neutral');
                    }
                    else{
                        actionNode = document.createElement('a');
                        if(rowAction.class){
                            actionNode.className = rowAction.class;
                        }
                        if(i != 0){
                            var actionSeparator = document.createElement('span');
                            actionSeparator.textContent = '|';
                            tdNode.appendChild(actionSeparator);
                        }
                    }

                    actionNode.id = rowAction.id+'-'+rowIdx;
                    actionNode.textContent = rowAction.label;
                
                    actionNode.addEventListener('click',$A.getCallback(function(evt){
                        self.fireDTActionClick(cmp,row,evt);
                    }));
                    
                    tdNode.setAttribute("data-label","Action");
                    tdNode.className = "slds-truncate";
                    tdNode.appendChild(actionNode);
                    tdActionFragments.appendChild(tdNode);
                }
            }
        }

        return tdActionFragments;
    },
    generateDataCell : function(row,columnConfig,config,rowIdx){
        var tdChildNode,
            column = columnConfig.name,
            type = columnConfig.type,
            value,self = this,
            tdNode = document.createElement("td");

        tdNode.className = "slds-truncate";
        value = _.get(row,column);
        
        if(!this.hasValue(value)){
            value = "";
        }
        
        if(type === "checkbox"){
            var chkObj = this.generateCheckbox('chk-'+rowIdx);
            var chkHolderNode = chkObj.parentNode;
            tdChildNode = chkObj.checkboxNode;
            tdChildNode.checked = value;
            tdChildNode.disabled = "disabled";
            tdNode.appendChild(chkHolderNode);
        }
        else if(value !== ''){            
            if(type != 'date' && type !== 'datetime'){
                if(type === 'reference'){
                    tdChildNode = document.createElement('a');
                    tdChildNode.textContent = value;
                    tdChildNode.setAttribute("data-recordid",row[columnConfig.value]);
                    //tdChildNode.href = 'javascript:void(0)';

                    //go to record detail
                    tdChildNode.addEventListener('click',$A.getCallback(function(evt){
                        self.navigateToDetailRecord(evt);
                    }));

                }
                else if(type === 'url'){
                    tdChildNode = document.createElement('a');
                    if(columnConfig.value){
                        tdChildNode.href = row[columnConfig.value];
                    }
                    else{
                        tdChildNode.href = value;
                    }
                    tdChildNode.target = "_blank";
                    tdChildNode.textContent = value;
                }
                else if(type === 'number'){
                    tdChildNode = document.createElement('span');
                    //var nf = $A.localizationService.getNumberFormat(this.getNumberFormat());
                    tdChildNode.textContent = $A.localizationService.formatNumber(value);
                }
                else if(type === 'currency'){
                    tdChildNode = document.createElement('span');
                    tdChildNode.textContent = $A.localizationService.formatCurrency(value);
                }
                else if(type === 'percent'){
                    tdChildNode = document.createElement('span');
                    tdChildNode.textContent = value+'%';
                }
                else if(type === 'email'){
                    tdChildNode = document.createElement('a');
                    tdChildNode.textContent = value;
                    tdChildNode.href = 'mailto:'+value;
                }
                else{
                    tdChildNode = document.createElement('span');
                    tdChildNode.textContent = value;
                }
            }
            else if(type === 'date'){
                tdChildNode = document.createElement('span');
                var dateFormat = columnConfig.format || 'D-MMM-YYYY';
                //tdChildNode.textContent = $A.localizationService.formatDate(value,'D-MMM-YYYY',this.getTimeZone());
                tdChildNode.textContent = moment.tz(value,this.getTimeZone()).format(dateFormat);
            }
            else if(type === 'datetime'){
                tdChildNode = document.createElement('span');
                var dateTimeFormat = columnConfig.format || 'D-MMM-YYYY HH:mm A';
                //tdChildNode.textContent = $A.localizationService.formatDateTime(value,'D-MMM-YYYY HH:mm A',);
                tdChildNode.textContent = moment.tz(value,this.getTimeZone()).format(dateTimeFormat);
            }

            tdChildNode.setAttribute('title',tdChildNode.textContent);
            tdNode.appendChild(tdChildNode);
        }
        
        tdNode.setAttribute('data-label',columnConfig.label);

        return tdNode;
    },
    
    generateCheckbox : function(id){
        var chkFrmNode = document.createElement("div");  
        chkFrmNode.className = "slds-form-element";

        var chkFrmCtrlNode = document.createElement("div");
        chkFrmCtrlNode.className = "slds-form-element__control";

        var chkHolder = document.createElement("span");
        chkHolder.className = "slds-checkbox";

        var chkLabel = document.createElement("label");
        chkLabel.className = "slds-checkbox__label";
        //chkLabel.setAttribute("for",id);

        var fauxNode = document.createElement("span");
        fauxNode.className = "slds-checkbox--faux"

        var checkboxNode = document.createElement("input");
        checkboxNode.type = "checkbox";
        checkboxNode.className = "slds-checkbox";
        //checkboxNode.id = id;

        chkLabel.appendChild(checkboxNode);
        chkLabel.appendChild(fauxNode);
        chkHolder.appendChild(chkLabel);
        chkFrmCtrlNode.appendChild(chkHolder);
        chkFrmNode.appendChild(chkFrmCtrlNode);
        
        return {"parentNode": chkFrmNode,"checkboxNode":checkboxNode};
    },
    hasValue : function(value) {
        if(typeof value === 'boolean' || value === 0){
            return true
        }
        else if(value){
            return true;
        }
        return false;
    },
    getDateFormat : function(){
        return $A.get("$Locale.dateFormat");
    },
    getDateTimeFormat : function(){
        return $A.get("$Locale.datetimeFormat");
    },
    getLocale : function(){
        return $A.get("$Locale.langLocale");
    },
    getTimeZone : function(){
        return $A.get("$Locale.timezone");
    },
    getCurrency : function(){
        return $A.get("$Locale.currency");
    },
    getNumberFormat : function(){
        return $A.get("$Locale.numberFormat");
    }
})