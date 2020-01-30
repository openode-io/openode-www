import axios from 'axios';

export default {
  name: 'Restart',

  props: {
      instance: Object
  },

  methods: {
    restartInstance(){

      this.processing = true;

      this.status = {
        message: 'restarting',
        level: 'warning',
        icon: 'fa fa-spin fa-spinner'
      };

      this.button = {
        text: 'Restarting...',
        disabled: true
      };

      this.$emit('updateStatus',{status:this.status,processing:this.processing});      

      axios.post(`/admin/instances/${this.instance.id}/restart.json`)
      .then(response => {
        this.status = response.data.status;        
        this.processing = false;

        this.button = {
          text: 'Restart',
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
        text: 'Restart',
        disabled: false
      },
      status: this.instance.status,
      processing: false
    }
  },  

  render() {
      return(
      <button type="button" class="dropdown-item" onClick={this.restartInstance} disabled={this.button.disabled}>{this.button.text}</button>
      )
  }
}