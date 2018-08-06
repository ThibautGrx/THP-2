import React from 'react';
import { Container, Row, Card, CardBody } from 'reactstrap';
import RegisterForm from './../components/register_form';
import LoginForm from './../components/login_form';

export default class Auth extends React.Component {
  render () {
    return(
    <Container fluid style={{backgroundColor:'#D3D3D3'}}>
      {console.log(this.state)}
      <Row style={{minHeight:'90vh',display:'flex',alignItems:'center',justifyContent:'center'}}>
          <Card style={{width:'310px',borderRadius: '5px',  boxShadow: '0px 2px 2px rgba(0, 0, 0, 0.3)'}}>
            <CardBody>
              {this.props.match.params.action === 'sign_in' ? <LoginForm /> : <RegisterForm />}
            </CardBody>
          </Card>
        </Row>
      </Container>
    )
  }
}
