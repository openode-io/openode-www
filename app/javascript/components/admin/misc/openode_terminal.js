import axios from 'axios'
import VueCommand from 'vue-command'
import 'vue-command/dist/vue-command.css'

export default {
  name: 'OpenodeTerminal',
  
  props: {
    instance: Object
  },

  data: () => ({
    current_path: '~',
    commands: {
      ls: () => {
        axios.get('/data/command.json', {path: this.current_path})
        .then(response => {
          return response.data.msg
        })
        .catch(err => {
          return err.response.data
        })
      },

      cd: (path) => {
        axios.get('/data/command.json')
        .then(response => {
          this.current_path = path

          return response.data.msg
        })
        .catch(err => {
          return err.response.data
        })
      }      
    }
  }),

  render() {
    return (
      <VueCommand commands={this.commands} prompt={`me@${this.instance.id}:#`} title={`me@${this.instance.id} ${this.current_path}`}/>
    )
  }
}