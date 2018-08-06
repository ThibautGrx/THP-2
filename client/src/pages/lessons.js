import React from 'react';
import { Container} from 'reactstrap';
import axios from 'axios';
import { Card, CardImg, CardText, CardBody, CardTitle, CardSubtitle, Button } from 'reactstrap';

export default class Lessons extends React.Component {
  constructor(props) {
  super(props);
  this.state = {
    lessons: null,
    errors: [],
  };
  }
  componentDidMount() {
    axios.get(`lessons`)
      .then(res => {
        this.setState({ lessons: res.data.lessons });
      }).catch((error) => {
        console.log(error)
    })
  }

  render() {
    return (
      <Container fluid style={{backgroundColor:'#D3D3D3',height:"100vh",paddingTop:'10px'}}>
        {this.state.lessons && this.state.lessons.map((lesson,index) =>
        <Card key={index} style={{width:'310px', marginTop:'10px'}}>
          <CardBody>
            <CardTitle>{lesson.title}</CardTitle>
            <CardText>{lesson.description}</CardText>
            <Button>Button</Button>
          </CardBody>
        </Card>
      )}

      </Container>

    );
  }
}
