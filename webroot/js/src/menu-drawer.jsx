var React = require('react');
var Drawer = require('material-ui/Drawer');
var MenuItem = require('material-ui/MenuItem');
var FontIcon = require('material-ui/FontIcon');

//import React from 'react';
//import Drawer from 'material-ui/Drawer';
//import MenuItem from 'material-ui/MenuItem';
//import FontIcon from 'material-ui/FontIcon';

var MenuDrawer = React.createClass({
    handleTitleClick: function() {
        window.location.href = this.props.titleUrl;
    },
    
    handleSelect: function(e) {
        var itemIndex = parseInt(e.currentTarget.dataset.itemIndex);
        var actionIndex = parseInt(e.currentTarget.dataset.actionIndex);
    
        var url = this.props.sections[itemIndex].actions[actionIndex].url;
        window.location.href = url;
    },
    
    render: function() {
        return (
            <Drawer
                docked={false}
                width={250}
                open={this.props.open}
                onRequestChange={this.props.handlers.requestChange}
            >
                <MenuItem onTouchTap={this.handleTitleClick} key="title" id="title"><h3 style={{margin: '10px 0 0'}}>this.props.title</h3></MenuItem>
                {this.props.items.map(function(item, itemIndex) {
                    return section.actions.map(function(action, actionIndex) {
                        var id = itemIndex + "-" + actionIndex;
                        if(action.icon) {
                            var icon = action.icon;
                        }
                        else {
                            var icon = section.icon;
                        }
                        if(action.menuLabel) {
                            var label = action.menuLabel;
                        }
                        else {
                            var label = section.title;
                        }
                        if(action.disabled) {
                            var disabled = action.disabled;
                        }
                        else {
                            var disabled = false;
                        }
                       
                        
                        return (
                            <MenuItem 
                                data-action-index={actionIndex}
                                data-item-index={itemIndex}
                                disabled={disabled}
                                id={id} 
                                key={id} 
                                onTouchTap={this.handleSelect} 
                            >
                                <FontIcon style={{top: '0.25em', marginRight: '5px'}} className="material-icons">{icon}</FontIcon>
                                {label}
                            </MenuItem>
                        );
                    }, this);
                }, this)}
            </Drawer>
        );
    }
});

module.exports = MenuDrawer;