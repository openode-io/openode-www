import axios from 'axios'
import DeploymentCard from './card'
import Loader from '../misc/loader'

export default {
  name: 'DeploymentList',

  props: {
    instance: Object
  },

  methods: {
    getDeployments (poll=false) {
      axios.get(`/admin/instances/${this.instance.id}/deployments.json`)
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
      deploymentss: [],
      updating: false,
      error: null
    }
  },

  mounted () {
    this.getInstances()
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
          <section class='d-flex mb-3'>
            <h1 class='h3 m-0 text-gray-800 flex-grow-1'>
              Instance Deployments
            </h1>
          </section>
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
