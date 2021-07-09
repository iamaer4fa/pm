<?php

require_once PATH_THIRDPARTY . 'propel/om/BaseObject.php';

require_once PATH_THIRDPARTY . 'propel/om/Persistent.php';


include_once PATH_THIRDPARTY . 'propel/util/Criteria.php';

include_once '{pathClasses}/' . SYS_SYS . '/classes/{className}Peer.php';

/**
 * Base class that represents a row from the '{tableName}' table.
 *
 *
 *
 * @package    classes.model.om
 */
abstract class Base{className} extends BaseObject  implements Persistent {


	/**
	 * The Peer class.
	 * Instance provides a convenient way of calling static methods on a class
	 * that calling code may not be able to identify.
	 * @var        {className}Peer
	 */
	protected static $peer;

<!-- START BLOCK : allColumns1 -->
	/**
	 * The value for the {var} field.
	 * @var        {type}
	 */
	protected {attribute};
<!-- END BLOCK : allColumns1 -->

	/**
	 * Flag to prevent endless save loop, if this object is referenced
	 * by another object which falls in this transaction.
	 * @var        boolean
	 */
	protected $alreadyInSave = false;

	/**
	 * Flag to prevent endless validation loop, if this object is referenced
	 * by another object which falls in this transaction.
	 * @var        boolean
	 */
	protected $alreadyInValidation = false;

<!-- START BLOCK : allColumns2 -->
  {getFunction}

<!-- END BLOCK : allColumns2 -->
<!-- START BLOCK : allColumns3 -->
  /**
	 * Set the value of [{var}] column.
	 *
	 * @param      {type} $v new value
	 * @return     void
	 */
  public function set{phpName}($v)
	{
    {setFunction}
	} // set{phpName}()

<!-- END BLOCK : allColumns3 -->

	/**
	 * Hydrates (populates) the object variables with values from the database resultset.
	 *
	 * An offset (1-based "start column") is specified so that objects can be hydrated
	 * with a subset of the columns in the resultset rows.  This is needed, for example,
	 * for results of JOIN queries where the resultset row includes columns from two or
	 * more tables.
	 *
	 * @param      ResultSet $rs The ResultSet class with cursor advanced to desired record pos.
	 * @param      int $startcol 1-based offset column which indicates which restultset column to start with.
	 * @return     int next starting column
	 * @throws     PropelException  - Any caught Exception will be rewrapped as a PropelException.
	 */
	public function hydrate(ResultSet $rs, $startcol = 1)
	{
		try {
<!-- START BLOCK : allColumns4 -->
      $this->{var} = $rs->get{type2}($startcol + {index});
<!-- END BLOCK : allColumns4 -->

			$this->resetModified();

			$this->setNew(false);

			// FIXME - using NUM_COLUMNS may be clearer.
			return $startcol + {totalColumns}; // {totalColumns} = {className}Peer::NUM_COLUMNS - {className}Peer::NUM_LAZY_LOAD_COLUMNS).

		} catch (Exception $e) {
			throw new PropelException("Error populating {className} object", $e);
		}
	}

	/**
	 * Removes this object from datastore and sets delete attribute.
	 *
	 * @param      Connection $con
	 * @return     void
	 * @throws     PropelException
	 * @see        BaseObject::setDeleted()
	 * @see        BaseObject::isDeleted()
	 */
	public function delete($con = null)
	{
		if ($this->isDeleted()) {
			throw new PropelException("This object has already been deleted.");
		}

		if ($con === null) {
			$con = Propel::getConnection({className}Peer::DATABASE_NAME);
		}

		try {
			$con->begin();
			{className}Peer::doDelete($this, $con);
			$this->setDeleted(true);
			$con->commit();
			require_once 'classes/model/AdditionalTables.php';
      $oAdditionalTables = new AdditionalTables();
      $aAdditionalTables = $oAdditionalTables->load({className}Peer::__UID__);
      if ($aAdditionalTables['ADD_TAB_SDW_LOG_DELETE'] == 1) {
        require_once 'classes/model/ShadowTable.php';
        $oShadowTable = new ShadowTable();
        $oShadowTable->create(array('ADD_TAB_UID' => {className}Peer::__UID__,
                                    'SHD_ACTION'  => 'DELETE',
                                    'SHD_DETAILS' => serialize($this->toArray(BasePeer::TYPE_FIELDNAME)),
                                    'USR_UID'     => (isset($_SESSION['USER_LOGGED']) ? $_SESSION['USER_LOGGED'] : ''),
                                    'APP_UID'     => (isset($_SESSION['APPLICATION']) ? $_SESSION['APPLICATION'] : ''),
                                    'SHD_DATE'    => date('Y-m-d H:i:s')));
      }
		} catch (PropelException $e) {
			$con->rollback();
			throw $e;
		}
	}

	/**
	 * Stores the object in the database.  If the object is new,
	 * it inserts it; otherwise an update is performed.  This method
	 * wraps the doSave() worker method in a transaction.
	 *
	 * @param      Connection $con
	 * @return     int The number of rows affected by this insert/update and any referring fk objects' save() operations.
	 * @throws     PropelException
	 * @see        doSave()
	 */
	public function save($con = null)
	{
		if ($this->isDeleted()) {
			throw new PropelException("You cannot save an object that has been deleted.");
		}

		if ($con === null) {
			$con = Propel::getConnection({className}Peer::DATABASE_NAME);
		}

		try {
			$con->begin();
			$affectedRows = $this->doSave($con);
			$con->commit();
			return $affectedRows;
		} catch (PropelException $e) {
			$con->rollback();
			throw $e;
		}
	}

	/**
	 * Stores the object in the database.
	 *
	 * If the object is new, it inserts it; otherwise an update is performed.
	 * All related objects are also updated in this method.
	 *
	 * @param      Connection $con
	 * @return     int The number of rows affected by this insert/update and any referring fk objects' save() operations.
	 * @throws     PropelException
	 * @see        save()
	 */
	protected function doSave($con)
	{
		$affectedRows = 0; // initialize var to track total num of affected rows
		if (!$this->alreadyInSave) {
			$this->alreadyInSave = true;


			// If this object has been modified, then save it to the database.
			if ($this->isModified()) {
				if ($this->isNew()) {
					$pk = {className}Peer::doInsert($this, $con);
					$affectedRows += 1; // we are assuming that there is only 1 row per doInsert() which
										 // should always be true here (even though technically
										 // BasePeer::doInsert() can insert multiple rows).

					$this->setNew(false);
					$sAction = 'INSERT';
					$sField  = 'ADD_TAB_SDW_LOG_INSERT';
				} else {
					$affectedRows += {className}Peer::doUpdate($this, $con);
					$sAction = 'UPDATE';
					$sField  = 'ADD_TAB_SDW_LOG_UPDATE';
				}
				require_once 'classes/model/AdditionalTables.php';
        $oAdditionalTables = new AdditionalTables();
        $aAdditionalTables = $oAdditionalTables->load({className}Peer::__UID__);
        if ($aAdditionalTables[$sField] == 1) {
				  require_once 'classes/model/ShadowTable.php';
          $oShadowTable = new ShadowTable();
          $oShadowTable->create(array('ADD_TAB_UID' => {className}Peer::__UID__,
                                      'SHD_ACTION'  => $sAction,
                                      'SHD_DETAILS' => serialize($this->toArray(BasePeer::TYPE_FIELDNAME)),
                                      'USR_UID'     => (isset($_SESSION['USER_LOGGED']) ? $_SESSION['USER_LOGGED'] : ''),
                                      'APP_UID'     => (isset($_SESSION['APPLICATION']) ? $_SESSION['APPLICATION'] : ''),
                                      'SHD_DATE'    => date('Y-m-d H:i:s')));
        }
				$this->resetModified(); // [HL] After being saved an object is no longer 'modified'
			}

			$this->alreadyInSave = false;
		}
		return $affectedRows;
	} // doSave()

	/**
	 * Array of ValidationFailed objects.
	 * @var        array ValidationFailed[]
	 */
	protected $validationFailures = array();

	/**
	 * Gets any ValidationFailed objects that resulted from last call to validate().
	 *
	 *
	 * @return     array ValidationFailed[]
	 * @see        validate()
	 */
	public function getValidationFailures()
	{
		return $this->validationFailures;
	}

	/**
	 * Validates the objects modified field values and all objects related to this table.
	 *
	 * If $columns is either a column name or an array of column names
	 * only those columns are validated.
	 *
	 * @param      mixed $columns Column name or an array of column names.
	 * @return     boolean Whether all columns pass validation.
	 * @see        doValidate()
	 * @see        getValidationFailures()
	 */
	public function validate($columns = null)
	{
		$res = $this->doValidate($columns);
		if ($res === true) {
			$this->validationFailures = array();
			return true;
		} else {
			$this->validationFailures = $res;
			return false;
		}
	}

	/**
	 * This function performs the validation work for complex object models.
	 *
	 * In addition to checking the current object, all related objects will
	 * also be validated.  If all pass then <code>true</code> is returned; otherwise
	 * an aggreagated array of ValidationFailed objects will be returned.
	 *
	 * @param      array $columns Array of column names to validate.
	 * @return     mixed <code>true</code> if all validations pass; array of <code>ValidationFailed</code> objets otherwise.
	 */
	protected function doValidate($columns = null)
	{
		if (!$this->alreadyInValidation) {
			$this->alreadyInValidation = true;
			$retval = null;

			$failureMap = array();


			if (($retval = {className}Peer::doValidate($this, $columns)) !== true) {
				$failureMap = array_merge($failureMap, $retval);
			}



			$this->alreadyInValidation = false;
		}

		return (!empty($failureMap) ? $failureMap : true);
	}

	/**
	 * Retrieves a field from the object by name passed in as a string.
	 *
	 * @param      string $name name
	 * @param      string $type The type of fieldname the $name is of:
	 *                     one of the class type constants TYPE_PHPNAME,
	 *                     TYPE_COLNAME, TYPE_FIELDNAME, TYPE_NUM
	 * @return     mixed Value of field.
	 */
	public function getByName($name, $type = BasePeer::TYPE_PHPNAME)
	{
		$pos = {className}Peer::translateFieldName($name, $type, BasePeer::TYPE_NUM);
		return $this->getByPosition($pos);
	}

	/**
	 * Retrieves a field from the object by Position as specified in the xml schema.
	 * Zero-based.
	 *
	 * @param      int $pos position in xml schema
	 * @return     mixed Value of field at $pos
	 */
	public function getByPosition($pos)
	{
		switch($pos) {
<!-- START BLOCK : allColumns5 -->
      case {index}:
				return $this->get{phpName}();
				break;
<!-- END BLOCK : allColumns5 -->
			default:
				return null;
				break;
		} // switch()
	}

	/**
	 * Exports the object as an array.
	 *
	 * You can specify the key type of the array by passing one of the class
	 * type constants.
	 *
	 * @param      string $keyType One of the class type constants TYPE_PHPNAME,
	 *                        TYPE_COLNAME, TYPE_FIELDNAME, TYPE_NUM
	 * @return     an associative array containing the field names (as keys) and field values
	 */
	public function toArray($keyType = BasePeer::TYPE_PHPNAME)
	{
		$keys = {className}Peer::getFieldNames($keyType);
		$result = array(
<!-- START BLOCK : allColumns6 -->
			$keys[{index}] => $this->get{phpName}(),
<!-- START BLOCK : allColumns6 -->
		);
		return $result;
	}

	/**
	 * Sets a field from the object by name passed in as a string.
	 *
	 * @param      string $name peer name
	 * @param      mixed $value field value
	 * @param      string $type The type of fieldname the $name is of:
	 *                     one of the class type constants TYPE_PHPNAME,
	 *                     TYPE_COLNAME, TYPE_FIELDNAME, TYPE_NUM
	 * @return     void
	 */
	public function setByName($name, $value, $type = BasePeer::TYPE_PHPNAME)
	{
		$pos = {className}Peer::translateFieldName($name, $type, BasePeer::TYPE_NUM);
		return $this->setByPosition($pos, $value);
	}

	/**
	 * Sets a field from the object by Position as specified in the xml schema.
	 * Zero-based.
	 *
	 * @param      int $pos position in xml schema
	 * @param      mixed $value field value
	 * @return     void
	 */
	public function setByPosition($pos, $value)
	{
		switch($pos) {
<!-- START BLOCK : allColumns7 -->
			case {index}:
				$this->set{phpName}($value);
				break;
<!-- END BLOCK : allColumns7 -->
		} // switch()
	}

	/**
	 * Populates the object using an array.
	 *
	 * This is particularly useful when populating an object from one of the
	 * request arrays (e.g. $_POST).  This method goes through the column
	 * names, checking to see whether a matching key exists in populated
	 * array. If so the setByName() method is called for that column.
	 *
	 * You can specify the key type of the array by additionally passing one
	 * of the class type constants TYPE_PHPNAME, TYPE_COLNAME, TYPE_FIELDNAME,
	 * TYPE_NUM. The default key type is the column's phpname (e.g. 'authorId')
	 *
	 * @param      array  $arr     An array to populate the object from.
	 * @param      string $keyType The type of keys the array uses.
	 * @return     void
	 */
	public function fromArray($arr, $keyType = BasePeer::TYPE_PHPNAME)
	{
		$keys = {className}Peer::getFieldNames($keyType);
<!-- START BLOCK : allColumns8 -->
		if (array_key_exists($keys[{index}], $arr)) $this->set{phpName}($arr[$keys[{index}]]);
<!-- END BLOCK : allColumns8 -->
	}

	/**
	 * Build a Criteria object containing the values of all modified columns in this object.
	 *
	 * @return     Criteria The Criteria object containing all modified values.
	 */
	public function buildCriteria()
	{
		$criteria = new Criteria({className}Peer::DATABASE_NAME);
<!-- START BLOCK : allColumns9 -->
		if ($this->isColumnModified({className}Peer::{name})) $criteria->add({className}Peer::{name}, $this->{var});
<!-- END BLOCK : allColumns9 -->
		return $criteria;
	}

	/**
	 * Builds a Criteria object containing the primary key for this object.
	 *
	 * Unlike buildCriteria() this method includes the primary key values regardless
	 * of whether or not they have been modified.
	 *
	 * @return     Criteria The Criteria object containing value(s) for primary key(s).
	 */
	public function buildPkeyCriteria()
	{
		$criteria = new Criteria({className}Peer::DATABASE_NAME);
<!-- START BLOCK : primaryKeys1 -->
		$criteria->add({className}Peer::{name}, $this->{var});
<!-- END BLOCK : primaryKeys1 -->
		return $criteria;
	}

	/**
	 * Returns the primary key for this object (row).
	 * @return     string
	 */
	public function getPrimaryKey()
	{
		{getPrimaryKeyFunction}
	}

	/**
	 * Generic method to set the primary key (add_tab_uid column).
	 *
	 * @param      string $key Primary key.
	 * @return     void
	 */
	public function setPrimaryKey($key)
	{
		{setPrimaryKeyFunction}
	}

	/**
	 * Sets contents of passed object to values from current object.
	 *
	 * If desired, this method can also make copies of all associated (fkey referrers)
	 * objects.
	 *
	 * @param      object $copyObj An object of {className} (or compatible) type.
	 * @param      boolean $deepCopy Whether to also copy all rows that refer (by fkey) to the current row.
	 * @throws     PropelException
	 */
	public function copyInto($copyObj, $deepCopy = false)
	{
<!-- START BLOCK : columnsWhitoutKeys -->
		$copyObj->set{phpName}($this->{var});
<!-- END BLOCK : columnsWhitoutKeys -->

		$copyObj->setNew(true);
<!-- START BLOCK : primaryKeys2 -->
		$copyObj->set{phpName}({defaultValue}); // this is a pkey column, so set to default value
<!-- END BLOCK : primaryKeys2 -->
	}

	/**
	 * Makes a copy of this object that will be inserted as a new row in table when saved.
	 * It creates a new object filling in the simple attributes, but skipping any primary
	 * keys that are defined for the table.
	 *
	 * If desired, this method can also make copies of all associated (fkey referrers)
	 * objects.
	 *
	 * @param      boolean $deepCopy Whether to also copy all rows that refer (by fkey) to the current row.
	 * @return     {className} Clone of current object.
	 * @throws     PropelException
	 */
	public function copy($deepCopy = false)
	{
		// we use get_class(), because this might be a subclass
		$clazz = get_class($this);
		$copyObj = new $clazz();
		$this->copyInto($copyObj, $deepCopy);
		return $copyObj;
	}

	/**
	 * Returns a peer instance associated with this om.
	 *
	 * Since Peer classes are not to have any instance attributes, this method returns the
	 * same instance for all member of this class. The method could therefore
	 * be static, but this would prevent one from overriding the behavior.
	 *
	 * @return     {className}Peer
	 */
	public function getPeer()
	{
		if (self::$peer === null) {
			self::$peer = new {className}Peer();
		}
		return self::$peer;
	}

} // Base{className}
