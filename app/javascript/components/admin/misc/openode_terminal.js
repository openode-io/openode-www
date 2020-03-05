import axios from 'axios'
import VueCommand from 'vue-command'
import 'vue-command/dist/vue-command.css'

export default {
  name: 'OpenodeTerminal',
  
  props: {
    instance: Object
  },

  data() {
    return {
      current_path: '~',
      url: `/admin/instances/${document.querySelector('#openode-terminal-console').getAttribute('data-instance-id')}/access/cmd`,
      commands: {
        ls: ({ _ }) => {          
          const self = this

          return new Promise(resolve => {
            axios.get(self.url, { cmd: `"${_.join(' ')}"`})
            .then(response => {            
              resolve(response.data.msg)
            })          
            .catch(err => {
              resolve(err.response.data);
            })
          })
        },
        cd: ({ _ }) => {          
          const self = this         

          return new Promise(resolve => {
            axios.get(self.url, { cmd: `"${_.join(' ')}"`})
            .then(response => {            
              self.current_path = _[1]
              resolve(response.data.msg)
            })          
            .catch(err => {
              resolve(err.response.data);
            })
          })
        }        
      }      
    }
  },

  render() {
    return (
      <VueCommand commands={this.commands} prompt={`me@${this.instance.name}:#`} title={`me@${this.instance.name} ${this.current_path}`}/>
    )
  }
}