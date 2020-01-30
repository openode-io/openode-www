import axios from 'axios';

export default {
  name: 'Deploy',

  props: {
      instance: Object
  },

  methods: {
    deployInstance(){

      this.processing = true;

      this.status = {
        message: 'deploying',
        level: 'warning',
        icon: 'fa fa-spin fa-spinner'
      };

      this.button = {
        text: 'Deploying...',
        disabled: true
      };

      this.$emit('updateStatus',{status:this.status,processing:this.processing});      

      axios.post(`/admin/instances/${this.instance.id}/deploy.json`)
      .then(response => {
        this.status = response.data.status;        
        this.processing = false;

        this.button = {
          text: 'Deploy',
          disabled: false
        };        

        this.$emit('updateStatus',{status:this.status,processing:this.processing});
      })
      .catch(err => {
        alert(err);
      })
    }
  },

  data() {
    return { 
      button: {
        text: 'Deploy',
        disabled: false
      },
      status: this.instance.status,
      processing: false
    }
  },  

  render() {
      return(
      <button type="button" class="dropdown-item" onClick={this.deployInstance} disabled={this.button.disabled}>{this.button.text}</button>
      )
  }
}