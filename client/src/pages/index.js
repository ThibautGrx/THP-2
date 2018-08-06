import React from 'react';
import { Container, Button} from 'reactstrap';
import THPLink from '../components/thp_link'

export default class Index extends React.Component {

  render() {
    return (
      <Container fluid style={{backgroundColor:'#D3D3D3'}}>
        <div style={{paddinTop:"60px", width:'100vh',height:'100vh'}}>
          <p>Bienvenue à THE HACKING PROJECT 2.0</p>
          <THPLink to="/lessons"><Button>Afficher les lessons</Button></THPLink>
        </div>
      </Container>
    );
  }
}
