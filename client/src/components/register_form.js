import React from 'react'
import { Col, Button, Form, FormFeedback, Label, FormGroup, InputGroup, InputGroupAddon, InputGroupText, Input } from 'reactstrap';


const EMAIL_REGEX = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

export default class registerForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      form: {
        username : '',
        email : '',
        password : '',
        passwordConfirmation : '',
      },
      errors: {
        username : [],
        email : [],
        password : [],
        passwordConfirmation : [],
      },

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
      errors.push(`${label} can't be blank`)
    }
    switch (label) {
      case 'email':
        if (!value.match(EMAIL_REGEX)){
          errors.push(`Email doesn't respect email format`)
        }
        break;
      case 'password':
        if (value.length < 8){
          errors.push(`Password should be 8 character minimum`)
        }
        break;
      case 'passwordConfirmation':
        if (value !== this.state.password){
          errors.push(`Password confirmation should match password`)
        }
        break;
      default:null
    }
    console.log(errors)
    return errors;
  };


  render () {
    const {email, username, password, passwordConfirmation} = this.state.form
    const errors = this.state.errors
    return(
      <Form>
        {[
          {label:'username', readableLabel:'Username',icon:"fa fa-user", placeholder:"azerty42", value:username,},
          {label:'email', readableLabel:'Email',icon:"fas fa-envelope",placeholder:"contact@thp2.com", value:email,},
          {label:'password', readableLabel:'Password',icon:"fa fa-key",placeholder:"********", value:password,},
          {label:'passwordConfirmation', readableLabel:'Password Confirmation',icon:"fa fa-key",placeholder:"********", value:passwordConfirmation,}
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
          <Button color="primary" size="lg" block>Register</Button>
        </div>
        <div style={{marginTop:'10px'}}>
          <Button color="secondary" block>Log-in</Button>
        </div>
      </Form>
    )
  }
}
