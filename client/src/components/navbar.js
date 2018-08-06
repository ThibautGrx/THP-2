import React from 'react';
import { Collapse, Navbar, NavbarToggler, NavbarBrand, Nav, NavItem, NavLink} from 'reactstrap';
import THPLink from './thp_link'

export default class NavBar extends React.Component {
  constructor(props) {
    super(props);

    this.toggle = this.toggle.bind(this);
    this.state = {
      isOpen: false
    };
  }
  toggle() {
    this.setState({
      isOpen: !this.state.isOpen
    });
  }
  render() {
    return (
      <div>
        <Navbar style={{backgroundColor:'#b70000'}} dark expand="md">
          <NavbarBrand href="/" style={{fontFamily:'Montserrat-Thin',fontSize:'0.85em'}}>THE HACKING PROJECT 2.0</NavbarBrand>
          <NavbarToggler onClick={this.toggle} />
          <Collapse isOpen={this.state.isOpen} navbar >
            <Nav className="ml-auto" navbar >
              <NavItem>
                  <NavLink tag='span'>
                    <THPLink to="/auth/sign_in">Se connecter</THPLink>
                  </NavLink>
              </NavItem>
              <NavItem>
                  <NavLink tag='span'>
                    <THPLink to="/auth/register">s'inscrire</THPLink>
                  </NavLink>
              </NavItem>
            </Nav>
          </Collapse>
        </Navbar>
      </div>
    );
  }
}
