import React from 'react';
import { Container} from 'reactstrap';

export default class Index extends React.Component {

  render() {
    return (
      <Container fluid style={{backgroundColor:'#D3D3D3'}}>
        <div style={{paddinTop:"60px", width:'100vh',height:'100vh'}}>
          Bienvenue à THE HACKING PROJECT 2.0
        </div>
      </Container>
    );
  }
}
