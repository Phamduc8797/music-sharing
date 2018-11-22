class Carousel extends React.Component {
  render() {
    return(
      <div id="carousel-example-generic" className="carousel slide" data-ride="carousel">
      <div className="carousel-inner">
        <div className="item active">
          <img src="assets/slide1.jpg" className="item height-40" />
          <div className="carousel-caption">
          </div>
        </div>
        <div className="item">
          <img src="assets/slide2.jpg" className="item height-40"/>
          <div className="carousel-caption">
          </div>
        </div>
      </div>
      <a className="left carousel-control" href="#carousel-example-generic" data-slide="prev">
        <span className="fa fa-angle-left"></span>
      </a>
      <a className="right carousel-control" href="#carousel-example-generic" data-slide="next">
        <span className="fa fa-angle-right"></span>
      </a>
    </div>
    )
  }
}
