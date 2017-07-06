var React = require('react');
var Container = require('./container.jsx');
var TopBar = require('./topbar.jsx');

//import React from 'react';
//import Container from './container.jsx';
//import TopBar from './topbar.jsx';

var Page = React.createClass({
    render: function() {
        var topbar = <TopBar />;
    
        return (
            <Container topbar={topbar}>
                <div>
                    Page content
                </div>
            </Container>
        );
    }
});

module.exports = Page;