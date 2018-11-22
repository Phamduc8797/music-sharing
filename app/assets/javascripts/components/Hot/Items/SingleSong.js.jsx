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
      play = (<i className="fa fa-stop fs-5" />)
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
      play = (<i className="fa fa-play-circle fs-5" />)
      showSong = null
    }
    let id = Math.floor(Math.random()*10)
    let path = "https://picsum.photos/190/170?image=106".concat(id.toString())
    let avatar = (<img src={path} className="img-fluid " alt="smaple image" />)
    author = song.authors.map(author => {
      return <a href={song_path}>Author: {author.name}</a>
    });

    singer = song.singers.map(singer => {
      return <a href={song_path}>Singer: {singer.name}</a>
    });

    return(
      <div className="col-xs-2 pb-1 height-20">
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
            {singer}
          </small>
          <div className="footer navbar-fixed-bottom">
            {showSong}
          </div>
        </div>
      </div>
    )
  }
}
