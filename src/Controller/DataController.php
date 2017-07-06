<?php
namespace App\Controller;

use App\Controller\AppController;

/**
 * Data Controller
 *
 * @property \App\Model\Table\DataTable $Data
 */
class DataController extends AppController
{
    /**
     * View method
     *
     * @return \Cake\Network\Response|null
     * @throws \Cake\Datasource\Exception\RecordNotFoundException When record not found.
     */
    public function view()
    {
        $this->viewBuilder()->layout('ajax');
        
        $currentUserId = $this->Auth->user('id');
        $tool = $this->SessionData->getLtiTool();
        //pr($currentUserId);
        //pr($tool);
        
        $dataQuery = $this->Data->find('all', [
            'conditions' => [
                'lti_consumer_key' => $tool->consumer->getKey(),
                'lti_context_id' => $tool->context->getId(),
                'lti_user_id' => $tool->user->getId(),
                'revision_parent' => 0,
            ]
        ]);
        
        $data = $dataQuery->toArray();
        //pr($data);

        $this->set('data', $data);
        $this->set('_serialize', ['data']);
    }

    /**
     * Save method
     *
     * @return \Cake\Network\Response|void Returns success message.
     */
    public function save()
    {
        //$this->request->allowMethod(['post']);
        $this->viewBuilder()->layout('ajax');

        $tool = $this->SessionData->getLtiTool();

        $dataArray = [
            'lti_consumer_key' => $tool->consumer->getKey(),
            'lti_context_id' => $tool->context->getId(),
            'lti_user_id' => $tool->user->getId(),
            'data' => 'some json',//$this->request->data['data'],
            'reivision_parent' => 0,
        ];
        
        
        $data = $this->Data->newEntity($dataArray);
        pr($data); 
        
        if ($this->Data->save($data)) {
            $message = 'success';
        } else {
            $message = 'error';
        }
        pr($message); exit;
        $this->set('message', $message);
        $this->set('_serialize', ['message']);
    }

}
