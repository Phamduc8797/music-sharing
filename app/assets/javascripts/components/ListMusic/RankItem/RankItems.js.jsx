class RankItems extends React.Component{
  constructor(props) {
    super(props)
    this.state = {
      i: 1
    }
  }

  render() {
    let {item} = this.props
    let {i} = this.state
    return(
      <div className="info-box hoverable">

        <span className= {"info-box-icon"}>
          <img src={item.image.image_url.url} class="img-fluid img-ranking" />
        </span>
        <span className="info-box-text">
          &nbsp;<a href="#"> {item.name}</a>
        </span>
        <span className="info-box-number">
          &nbsp;<a href="#"><i className="fa fa-headphones"></i> {item.view}</a>
        </span>
      </div>
    )
  }
}
