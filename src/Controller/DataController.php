<?php
namespace App\Controller;

use App\Controller\AppController;
use Cake\Network\Exception\InternalErrorException;

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
        
        $data = $this->Data->getLatestUserData($tool)->toArray();
        $data['data'] = json_decode($data['data']);
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
        $this->request->allowMethod(['post']);
        $this->viewBuilder()->layout('ajax');

        $tool = $this->SessionData->getLtiTool();

        $dataToSave = [];
        
        $dataEntity = $this->Data->getLatestUserData($tool);
        $existingDataArray = $dataEntity->toArray();
        
        //pr($this->request->data); exit;
        $data = json_encode($this->request->data);
        
        //If there is existing data, backup it up and then patch with new data
        if(!empty($dataEntity)) {
            $existingId = $existingDataArray['id'];   //Get the ID of the existing record
            unset($existingDataArray['id']);  //Unset the ID for the old data
            $existingDataArray['revision_parent'] = $existingId;  //Set the revision parent to the existing ID
            $dataToSave[] = $this->Data->newEntity($existingDataArray);   //Hydrate the old data
            
            $dataEntity->data = $data;
            $dataToSave[] = $dataEntity; 
        }
        //Otherwise, just save new data
        else {
            $newDataArray = $this->Data->getBasicConditions($tool);  //Get the LTI values
            $newDataArray['revision_parent'] = 0;    //No revision parent
            $newDataArray['data'] = $data;   //Add the data
            $dataToSave[] = $this->Data->newEntity($newDataArray);   //Hydrate the data
        }
        
        //pr($dataToSave); exit;
        
        if ($this->Data->saveMany($dataToSave)) {
            $message = 'success: ' . time();
            $this->set('message', $message);
            $this->set('_serialize', ['message']);
        } else {
            throw new InternalErrorException(__('Error saving data'));
        }
    }

}
