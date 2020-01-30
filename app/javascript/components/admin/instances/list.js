import axios from 'axios';
import InstanceCard from './card';

export default{
  name: 'InstanceList',
  
  methods: {
    getInstances() {
      axios.get("/data/instances.json")
      .then(response => {
        this.instances = response.data;
      })
      .catch(err => {
        console.log(err)
      })
    }
  },

  data() {
    return { instances: [] }
  },

  mounted() {
    this.getInstances()
  },  

  render() {
    if (this.instances.length > 0){
      return(
        <div id="admin-instances">
          <section class="d-flex mb-3">
            <h1 class="h3 m-0 text-gray-800 flex-grow-1">
              Instances
            </h1>
            <a class="btn btn-sm btn-outline-dark" href="/admin/instances/new">
              <i class="fa fa-plus"></i> Add New
            </a>            
          </section>
          <section>
            <div class="row">
              {this.instances.map(instance => (
                <InstanceCard instance={instance} />
              ))}
            </div>
          </section>
        </div>
      )
    }else{
      return(
        <div class="row">
          <i class="fa fa-spinner fa-spin fa-2x"></i>
        </div>
      )
    }
  }
};