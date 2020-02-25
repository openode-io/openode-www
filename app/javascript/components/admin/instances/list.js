import axios from 'axios'
import InstanceCard from './card'
import New from './actions/new'
import Loader from '../misc/loader'

export default {
  name: 'InstanceList',

  methods: {
    getInstances (poll=false) {      
      axios.get('/admin/instances.json')
        .then(response => {
          this.instances = response.data
          this.updating = false
          this.loading = false

          if (poll) {            
            this.pollInstancesStatus()
          }
        })
        .catch(err => {
          this.displayAlert({error:err.response.data.error,level:'warning'})
        })
    },
    
    displayAlert (data) {
      this.alert.message = data.error
      this.alert.level = data.level
    },

    pollInstancesStatus () {    
      if(this.poll_start == null){
        this.poll_start = Date.now()        
      }      

      if ((Date.now() - this.poll_start) > 300000) {
        this.poll_start = null
        return;
      }      

      setTimeout( () => this.runPoller(), 30000 );
    },

    runPoller() {
      this.updating = true
      this.getInstances(true)
    }
  },

  data () {
    return { 
      instances: [],
      loading: false,
      updating: false,
      error: false,
      poll_start: false,
      alert: false
    }
  },

  mounted () {
    this.loading = true
    this.getInstances()
  },

  render () {
    let updating_box = null
    let error_box = null

    if (this.updating){
      updating_box = <div class="row animated fadeIn">
        <div class="alert alert-yellow">
          <i class="fa fa-spin fa-spinner" /> Updating instances...
        </div>
      </div>
    }

    if (this.alert) {
      error_box =   <b-alert variant={this.alert.level} show dismissible>
        {this.alert.message}
      </b-alert>
    }
    
    if (this.loading){
      return ( <Loader /> )
    }else{
      return (
        <div id='admin-instances' onGetInstances={this.getInstances}>
          {error_box}
          <section class='d-flex mb-3'>
            <h1 class='h3 m-0 text-gray-800 flex-grow-1'>
              Instances
            </h1>
            <New onInstancesUpdate={this.getInstances}/>
          </section>
          <section>
            <div class='row'>
              {this.instances.map(instance => (
                <InstanceCard instance={instance} key={`ope-instance-${instance.id}`} onDisplayAlert={this.displayAlert} onPollInstancesStatus={this.pollInstancesStatus}/>
              ))}
            </div>
          </section>
        </div>
      )
    }
  }
}
