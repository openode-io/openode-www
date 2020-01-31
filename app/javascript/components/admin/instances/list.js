import axios from 'axios'
import InstanceCard from './card'
import New from './actions/new'

export default {
  name: 'InstanceList',

  methods: {
    getInstances () {
      axios.get('/data/instances.json')
        .then(response => {
          this.instances = response.data
        })
        .catch(err => {
          console.log(err)
        })
    }
  },

  data () {
    return { instances: [] }
  },

  mounted () {
    this.getInstances()
  },

  render () {
    if (this.instances.length > 0) {
      return (
        <div id='admin-instances'>
          <section class='d-flex mb-3'>
            <h1 class='h3 m-0 text-gray-800 flex-grow-1'>
              Instances
            </h1>
            <New />
          </section>
          <section>
            <div class='row'>
              {this.instances.map(instance => (
                <InstanceCard instance={instance} key={`ope-instance-${instance.id}`} />
              ))}
            </div>
          </section>
        </div>
      )
    } else {
      return (
        <div class='row'>
          <i class='fa fa-spinner fa-spin fa-2x' />
        </div>
      )
    }
  }
}
