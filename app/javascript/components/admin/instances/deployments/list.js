import axios from 'axios'
import DeploymentCard from './card'
import Loader from '../../misc/loader'

export default {
  name: 'DeploymentList',

  props: {
    instance: Object
  },

  methods: {
    getDeployments () {
      axios.get(`/data/deployments.json`)
        .then(response => {
          this.deployments = response.data
          this.updating = false
        })
        .catch(err => {
          console.error(err)
        })
    },
    
    displayAlert (data) {
      this.alert.message = data.error
      this.alert.level = data.level
    }
  },

  data () {
    return { 
      deployments: [],
      updating: false,
      error: false
    }
  },

  mounted () {
    this.getDeployments()
  },

  render () {
    let updating_box = null
    let error_box = null

    if (this.error) {
      error_box = <b-alert variant={this.alert.level} show dismissible>
        {this.alert.message}
      </b-alert>
    }
    
    if (this.deployments.length > 0) {
      return (
        <div id={`admin-instance-{this.instance.id}-deployments`} onGetDeployments={this.getDeployments}>
          {error_box}
          <section>
            <div class='row'>
              {this.deployments.map(deployment => (
                <DeploymentCard deployment={deployment} instance={this.instance} key={`ope-deployment-${deployment.id}`} onDisplayAlert={this.displayAlert}/>
              ))}
            </div>
          </section>
        </div>
      )
    } else {
      return ( <Loader /> )
    }
  }
}
