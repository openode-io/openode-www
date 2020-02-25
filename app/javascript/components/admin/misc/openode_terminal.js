import {taskList, commandList} from '../../../utils/console'
import VueTerminal from 'vue-terminal'

export default {
  name: 'OpenodeTerminal',
  
  data() {
    return {
      taskList,
      commandList
    }
  },

  render() {
    return (
      <VueTerminal task-list={this.taskList} command-list={this.commandList} title="opeNode Terminal" greeting="Welcome to the opeNode terminal." prompt="$ opeNode" />
    )
  }
}