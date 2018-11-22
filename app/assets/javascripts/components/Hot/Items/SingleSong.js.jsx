class SingleSong extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      isShow: false
    }
    this.onclick = this.onclick.bind(this)
    this.removeButton = this.removeButton.bind(this)
  }

  onclick() {
    this.setState({
      isShow: !this.state.isShow
    })
  }

  removeButton() {
    this.setState({
      isShow: false
    })
  }

  render() {
    const {isShow} = this.state
    const {song} = this.props
    let song_path = "songs/".concat(song.id.toString())
    let bass = [...Array(38)].map(i => {
      return <Bass key={i}></Bass>
    })
    if (isShow) {
      play = (<i className="fa fa-stop fs-10" />)
      showSong = (
        <div className="container-audio">
          <div className="row">
            <div className="col-md-11">
              <p className="pl-5 white-text font-weight-bold">Name Song: {song.name}</p>
              <audio controls loop autoPlay>
                <source src={song.song_url.url} type="audio/mpeg" />
              </audio>
            </div>
            <div className="col-md-1">
              <i className="fa fa-remove" onClick={this.removeButton}></i>
            </div>
            <div className="col-md-12">{bass}</div>
          </div>
        </div>
      )
    } else {
      play = (<i className="fa fa-play-circle fs-10" />)
      showSong = null
    }
    return(
      <div className="col-xs-2 pb-1">
        <div className="view overlay" onClick={this.onclick}>
          <img src={song.image.image_url.url} className="img-fluid height-100" alt="smaple image" />
          <div className="mask flex-center rgba-cyan-strong">
            <p className="white-text font-weight-bold play" >
              {play}
            </p>
          </div>
        </div>
        <div className="m-0">
          <h4 className="mb-0">
            <a href={song_path} className="black-text">{song.name}</a>
          </h4>
          <small>
            <a href={song_path}>View: {song.view}</a>
          </small>
          <div className="footer navbar-fixed-bottom">
            {showSong}
          </div>
        </div>
      </div>
    )
  }
}
