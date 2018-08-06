import React from 'react'
import { Col, Button, Form, FormFeedback, Label, FormGroup, InputGroup, InputGroupAddon, InputGroupText, Input } from 'reactstrap';

export default class loginForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      form: {
        login : '',
        password : '',
      },
      errors: {
        login : '',
        password : '',
      }
    }
    this.handleValueChange = this.handleValueChange.bind(this);
    this.handleInputBlur = this.handleInputBlur.bind(this);
    this.isFieldValid = this.isFieldValid.bind(this);
  }

  handleValueChange(label,value) {
    this.setState({form: {...this.state.form, [label]:value} });
  };
  handleInputBlur(label) {
    this.setState({errors: {...this.state.errors, [label]: this.isFieldValid(label, this.state.form[label]) }} )
  };

  isFieldValid(label, value) {
    let errors = []
    if (value === ''){
      errors.push(`You should enter your ${label}`)
    }
    return errors;
  };


  render () {
    const {loggin, password} = this.state.form
    const errors = this.state.errors
    return(
      <Form>
        {[
          {label:'login', readableLabel:'Login (username or email)',icon:"fa fa-user"  ,placeholder:"contact@thp2.com", value:loggin,},
          {label:'password', readableLabel:'Password', icon:"fa fa-key", placeholder:"********", value:password,},
        ].map((value,index) =>
        <FormGroup key={index}>
          <Label for={value.label} >{value.readableLabel}</Label>
          <Col style={{padding:0}}>
            <InputGroup>
              <InputGroupAddon addonType="prepend">
                <InputGroupText><i className={value.icon} aria-hidden="true"></i></InputGroupText>
              </InputGroupAddon>
              <Input placeholder={value.placeholder} value={value.value}
                onChange={e => this.handleValueChange(value.label,e.target.value)}
                 onBlur={e => this.handleInputBlur(value.label, e.target.value)}
                 invalid={errors[value.label].length > 0}
                 />
               {errors[value.label].length > 0 && errors[value.label].map((error,index) =>
                 <FormFeedback key={index}>{error}</FormFeedback>
                 )}
            </InputGroup>
          </Col>
        </FormGroup>
          )
        }

        <div>
          <Button color="primary" size="lg" block>Log-in</Button>
        </div>
        <div style={{marginTop:'10px'}}>
          <Button color="secondary" block>Register</Button>
        </div>
      </Form>
    )
  }
}
