var getMuiTheme = require('material-ui/styles/getMuiTheme');
var {indigoA100, indigoA200, indigo500, indigo700, lightBlack, lightBlue300} = require('material-ui/styles/colors');

//import getMuiTheme from 'material-ui/styles/getMuiTheme';
//import {indigoA100, indigoA200, indigo500, indigo700, lightBlack, lightBlue300} from 'material-ui/styles/colors';

module.exports = getMuiTheme({
  fontFamily: 'Roboto, sans-serif',
  palette: {
    primary1Color: indigo500,
    primary2Color: indigo700,
    primary3Color: lightBlack,
    //accent1Color: indigoA400,
    accent1Color: indigoA100,
    pickerHeaderColor: indigo500,
  }
});

/*export default {
  fontFamily: 'Roboto, sans-serif',
  palette: {
    primary1Color: indigo500,
    primary2Color: indigo700,
    primary3Color: lightBlack,
    //accent1Color: indigoA400,
    accent1Color: indigoA100,
    pickerHeaderColor: indigo500,
  }
};*/