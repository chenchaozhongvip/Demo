import React, { Component } from 'react';
import { AppRegistry, Image, View, Text, StyleSheet} from 'react-native';

const styles = StyleSheet.create({
  blue:{
    color: 'blue',
    fontSize: 30,
  },
  red:{
    color: 'red',
    fontSize: 15,
  }
});

class AwesomeProject extends Component {
  
  render () {
    let pic = {
      uri : 'https://upload.wikimedia.org/wikipedia/commons/d/de/Bananavarieties.jpg'
    };
    return (
      <View style={{height: 300, flexDirection: 'row'}}>
        <View style={{flex: 2, backgroundColor: 'blue'}}/>
        <View style={{left: 100,flex: 1,backgroundColor: 'red'}}/>
        <View style={{flex: 3,backgroundColor: 'green'}}/>
     </View> 
    );
  }
}

class Geet extends Component {
  constructor (props) {
    super (props);
    this.state = {showText: true};

    setInterval(()=>{
      this.setState({ showText: !this.state.showText});
    },1000);
  }


  render () {
    let disp = this.state.showText? this.props.text:'';
    return (<Text>{disp}</Text>);
  }
}

AppRegistry.registerComponent('AwesomeProject',() =>AwesomeProject);