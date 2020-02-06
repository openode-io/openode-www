import axios from 'axios'

export default {
  name: 'Stop',

  props: {
    instance: Object
  },

  methods: {
    stopInstance () {
      this.processing = true

      this.status = {
        message: 'stopping',
        level: 'warning',
        icon: 'fa fa-spin fa-spinner'
      }

      this.button = {
        text: 'Stopping...',
        disabled: true
      }

      this.$emit('updateStatus', { status: this.status, processing: this.processing, poll: false })

      axios.post(`/admin/instances/${this.instance.id}/stop.json`)
        .then(response => {
          this.status = response.data.status
          this.processing = false

          this.button = {
            text: 'Stop',
            disabled: false
          }

          this.$emit('updateStatus', { status: this.status, processing: this.processing, poll: true })
        })
        .catch(err => {
          this.button = {
            text: 'Stop',
            disabled: false
          }
                    
          this.$emit('displayError', { error: err })          
        })
    }
  },

  data () {
    return {
      button: {
        text: 'Stop',
        disabled: false
      },
      status: this.instance.status,
      processing: false
    }
  },

  render () {
    return (
      <button type='button' class='dropdown-item' onClick={this.stopInstance} disabled={this.button.disabled}>{this.button.text}</button>
    )
  }
}
